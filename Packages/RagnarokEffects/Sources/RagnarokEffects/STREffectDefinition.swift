//
//  STREffectDefinition.swift
//  RagnarokEffects
//
//  Created by Leon Li on 2026/6/25.
//

// Ported from roBrowserLegacy EffectTable.js (Swift property → JS key):
// - fileName:           file
// - soundName:          wav
// - randomNumberRange:  rand
// - attachedToTarget:   attachedEntity
// - fallbackFileNames:  fallback ([RagOff iPad Mod] tried in order when the file is missing)
public struct STREffectDefinition: Sendable {
    public var fileName: String
    public var soundName: String?
    public var randomNumberRange: ClosedRange<Int>?

    public var attachedToTarget: Bool

    public var fallbackFileNames: [String] = []
}

extension EffectDefinition {
    public static func str(
        fileName: String,
        soundName: String? = nil,
        randomNumberRange: ClosedRange<Int>? = nil,
        attachedToTarget: Bool,
        fallbackFileNames: [String] = []
    ) -> EffectDefinition {
        let definition = STREffectDefinition(
            fileName: fileName,
            soundName: soundName,
            randomNumberRange: randomNumberRange,
            attachedToTarget: attachedToTarget,
            fallbackFileNames: fallbackFileNames
        )
        return .str(definition)
    }
}
