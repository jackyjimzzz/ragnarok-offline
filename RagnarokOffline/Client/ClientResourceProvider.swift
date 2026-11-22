//
//  ClientResourceProvider.swift
//  RagnarokOffline
//
//  Created by Leon Li on 2026/6/24.
//

import Foundation
import RagnarokGRF
import RagnarokResources

let localClientURL = URL.documentsDirectory
let remoteClientCacheURL = URL.cachesDirectory.appending(path: "com.github.arkadeleon.ragnarok-offline.remote-client")

actor ClientResourceProvider: ResourceProvider {
    let localProvider: LocalClientResourceProvider
    private(set) var remoteProvider: RemoteClientResourceProvider

    init(remoteClientURL: URL?, isRemoteClientEnabled: Bool) {
        localProvider = LocalClientResourceProvider(url: localClientURL)
        remoteProvider = RemoteClientResourceProvider(
            url: remoteClientURL,
            cacheURL: remoteClientCacheURL,
            isEnabled: isRemoteClientEnabled
        )
    }

    func configure(remoteClientURL: URL?, isRemoteClientEnabled: Bool) {
        remoteProvider = RemoteClientResourceProvider(
            url: remoteClientURL,
            cacheURL: remoteClientCacheURL,
            isEnabled: isRemoteClientEnabled
        )
    }

    func contentsOfResource(at path: ResourcePath) async throws -> Data {
        do {
            return try await localProvider.contentsOfResource(at: path)
        } catch ResourceError.resourceNotFound {
            return try await remoteProvider.contentsOfResource(at: path)
        }
    }
}

final class LocalClientResourceProvider: ResourceProvider {
    let url: URL

    private let grfArchives: [GRFArchive]

    init(url: URL) {
        self.url = url

        // [RagOff iPad Mod] Read several GRF archives in priority order, like the PC client's DATA.INI.
        // Archives that are not in the folder are skipped.
        let grfNames = ["twdata.grf", "data.grf", "twdata0_lite.grf"]
        grfArchives = grfNames
            .map { url.appending(path: $0) }
            .filter { FileManager.default.fileExists(atPath: $0.path(percentEncoded: false)) }
            .map { GRFArchive(url: $0) }
    }

    func contentsOfResource(at path: ResourcePath) async throws -> Data {
        let fileURL = url.absoluteURL.appending(path: L2K(path))
        if FileManager.default.fileExists(atPath: fileURL.path(percentEncoded: false)) {
            return try Data(contentsOf: fileURL)
        }

        let grfPath = GRFPath(components: path.components)
        for grfArchive in grfArchives {
            if let entryNode = await grfArchive.entryNode(at: grfPath) {
                return try await grfArchive.contentsOfEntryNode(at: entryNode.path)
            }
        }

        throw ResourceError.resourceNotFound(path)
    }

    func locatorOfResource(at path: ResourcePath) async throws -> FileLocator {
        let fileURL = url.absoluteURL.appending(path: L2K(path))
        if FileManager.default.fileExists(atPath: fileURL.path(percentEncoded: false)) {
            return .url(fileURL)
        }

        let grfPath = GRFPath(components: path.components)
        for grfArchive in grfArchives {
            if let entryNode = await grfArchive.entryNode(at: grfPath) {
                return .grfArchiveNode(grfArchive, entryNode)
            }
        }

        throw ResourceError.resourceNotFound(path)
    }
}

actor RemoteClientResourceProvider: ResourceProvider {
    let url: URL?
    let cacheURL: URL?
    let isEnabled: Bool

    init(url: URL?, cacheURL: URL? = nil, isEnabled: Bool) {
        self.url = url
        self.cacheURL = cacheURL
        self.isEnabled = isEnabled
    }

    func contentsOfResource(at path: ResourcePath) async throws -> Data {
        guard let url, isEnabled else {
            throw ResourceError.resourceNotFound(path)
        }

        if let cacheURL {
            let cachedFileURL = cacheURL.absoluteURL.appending(path: L2K(path))
            if FileManager.default.fileExists(atPath: cachedFileURL.path(percentEncoded: false)) {
                return try Data(contentsOf: cachedFileURL)
            }
        }

        logger.info("Start downloading resource: \(path)")

        let remoteResourceURL = url.appending(path: path)
        let request = URLRequest(url: remoteResourceURL, cachePolicy: .reloadIgnoringLocalCacheData)
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ResourceError.resourceNotFound(path)
        }

        if let cacheURL {
            let cachedFileURL = cacheURL.appending(path: L2K(path))
            try? FileManager.default.createDirectory(at: cachedFileURL.deletingLastPathComponent(), withIntermediateDirectories: true)
            try? data.write(to: cachedFileURL)
        }

        return data
    }
}
