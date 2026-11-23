//
//  MapSceneView.swift
//  RagnarokGame
//
//  Created by Leon Li on 2026/5/30.
//

import SwiftUI

struct MapSceneView: View {
    var runtime: MapSceneRuntime

    #if os(visionOS)
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    #endif

    @Environment(PlaySession.self) private var playSession

    @State private var screenWidth: CGFloat = 320
    @State private var actionBarHeight: CGFloat = 0
    @State private var presentedMenuItem: MenuItem?

    // [RagOff iPad Mod] Big touch controls (switchable back at any time) and auto hunt.
    @AppStorage("ragOffMobileControls") private var ragOffMobileControls = true
    @State private var ragOffAutoHunt = false

    var body: some View {
        ZStack {
            #if os(visionOS)
            Color.clear
                .onAppear {
                    Task {
                        await openImmersiveSpace(id: GameSession.immersiveSpaceID)
                    }
                }
                .onDisappear {
                    Task {
                        await dismissImmersiveSpace()
                    }
                }
            #elseif os(iOS)
            MapView(runtime: runtime, isWidescreen: isWidescreen)
            #else
            MapView(runtime: runtime)
            #endif
        }
        .overlay(alignment: .bottomLeading) {
            #if os(macOS)
            ChatBoxView()
                .frame(width: 440)
            #endif
        }
        .overlay(alignment: .bottomTrailing) {
            if isWidescreen {
                actionBar
                    .padding(.trailing, 16)
                    .padding(.bottom, 16)
            }
        }
        .overlay(alignment: .bottom) {
            if !isWidescreen {
                actionBar
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
                    .padding(.bottom, ChatBoxView.contentHeight(for: .compact) + 8)
            }
        }
        .overlay(alignment: .topLeading) {
            VStack(alignment: .leading, spacing: 0) {
                BasicInfoView(character: playSession.character, status: playSession.playerStatus)

                MenuView { item in
                    if item == presentedMenuItem {
                        presentedMenuItem = nil
                    } else {
                        presentedMenuItem = item
                    }
                }
                // [RagOff iPad Mod] Bigger menu icons for fingers.
                .scaleEffect(1.5, anchor: .topLeading)
            }
        }
        .overlay(alignment: .topTrailing) {
            VStack(alignment: .trailing, spacing: 8) {
                MinimapView(scene: runtime.scene)

                StatusIconBarView(statusChanges: playSession.statusChanges)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 16)
            .padding(.trailing, 16)
            .padding(.bottom, statusIconBarBottomPadding)
        }
        .ignoresSafeArea()
        .overlay {
            #if os(iOS)
            ChatBoxView()
                .frame(width: chatBoxWidth)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: isWidescreen ? .bottomLeading : .bottom)
            #endif
        }
        .overlay(alignment: .center) {
            if let item = presentedMenuItem {
                switch item {
                case .status:
                    StatusView(status: playSession.playerStatus) {
                        presentedMenuItem = nil
                    }
                    .scaleEffect(1.3)
                case .equipment:
                    EquipmentView {
                        presentedMenuItem = nil
                    }
                case .inventory:
                    InventoryView(inventory: playSession.inventory) {
                        presentedMenuItem = nil
                    }
                case .skill:
                    SkillListView(skillList: playSession.skillList) {
                        presentedMenuItem = nil
                    }
                case .worldMap:
                    WorldMapView(currentMapName: runtime.scene.mapName) {
                        presentedMenuItem = nil
                    }
                case .options:
                    OptionsView(isPlayerDead: runtime.scene.state.isPlayerDead) {
                        presentedMenuItem = nil
                    }
                    .scaleEffect(1.3)
                }
            }
        }
        .overlay(alignment: .center) {
            if let dialog = playSession.dialog {
                NPCDialogView(dialog: dialog)
                    .scaleEffect(1.3)
            }
            if let warpList = playSession.warpList {
                WarpListView(warpList: warpList)
                    .scaleEffect(1.3)
            }
            if let npcShop = playSession.npcShop {
                NPCShopView(shop: npcShop)
            }
            if playSession.dealSelectionNPCID != nil {
                NPCShopDealTypeView()
                    .scaleEffect(1.3)
            }
            if let storage = playSession.storage {
                StorageView(storage: storage)
            }
        }
        .onChange(of: runtime.scene.state.isPlayerDead) { _, newValue in
            if newValue {
                presentedMenuItem = .options
            } else if presentedMenuItem == .options {
                presentedMenuItem = nil
            }
        }
        .onChange(of: playSession.storage != nil) { _, isStorageOpen in
            if isStorageOpen {
                presentedMenuItem = nil
            }
        }
        .ignoresSafeArea(.container)
        .onGeometryChange(for: CGFloat.self) { geometryProxy in
            geometryProxy.size.width + geometryProxy.safeAreaInsets.leading + geometryProxy.safeAreaInsets.trailing
        } action: { containerWidth in
            self.screenWidth = containerWidth
        }
    }

    private var actionBar: some View {
        VStack(alignment: .trailing, spacing: 6) {
            Button {
                ragOffMobileControls.toggle()
                if !ragOffMobileControls {
                    ragOffAutoHunt = false
                }
            } label: {
                Text(verbatim: ragOffMobileControls ? "切換：原版按鍵" : "切換：大按鍵模式")
                    .font(.game(size: 11, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Capsule().fill(Color.black.opacity(0.45)))
            }
            .buttonStyle(.plain)

            if ragOffMobileControls {
                RagOffMobileActionBarView(
                    selectedTargetType: runtime.scene.state.selectedTargetType,
                    isAutoHunting: ragOffAutoHunt,
                    onToggleAutoHunt: {
                        ragOffAutoHunt.toggle()
                    },
                    onTargetAction: {
                        runtime.scene.performTargetAction()
                    },
                    onSelectNextTarget: {
                        runtime.selectNextTarget()
                    },
                    onDeselectTarget: {
                        runtime.scene.selectTarget(nil)
                    },
                    onPickup: {
                        runtime.scene.pickUpNearestItem()
                    },
                    onSit: {
                        runtime.scene.toggleSit()
                    },
                    onShortcut: { shortcut in
                        playSession.useShortcut(shortcut)
                    }
                )
            } else {
                ActionBarView(
                    selectedTargetType: runtime.scene.state.selectedTargetType,
                    onTargetAction: {
                        runtime.scene.performTargetAction()
                    },
                    onSelectNextTarget: {
                        runtime.selectNextTarget()
                    },
                    onDeselectTarget: {
                        runtime.scene.selectTarget(nil)
                    },
                    onPickup: {
                        runtime.scene.pickUpNearestItem()
                    },
                    onSit: {
                        runtime.scene.toggleSit()
                    },
                    onShortcut: { shortcut in
                        playSession.useShortcut(shortcut)
                    }
                )
            }
        }
        .task(id: ragOffAutoHunt) {
            await runRagOffAutoHunt()
        }
        .onGeometryChange(for: CGFloat.self) { geometryProxy in
            geometryProxy.size.height
        } action: { height in
            actionBarHeight = height
        }
    }

    /// [RagOff iPad Mod] While auto hunt is on, keep attacking the nearest monster:
    /// pick a new one when there is no living monster selected, and attack again
    /// when the player has been standing idle next to the selected one.
    private func runRagOffAutoHunt() async {
        guard ragOffAutoHunt else {
            return
        }
        var idleTicks = 0
        while ragOffAutoHunt && !Task.isCancelled {
            let scene = runtime.scene
            if !scene.state.isPlayerDead {
                if let target = scene.selectedTarget, target.type == .monster {
                    if scene.player.action.actionType == .idle {
                        idleTicks += 1
                    } else {
                        idleTicks = 0
                    }
                    if idleTicks >= 3 {
                        idleTicks = 0
                        scene.performTargetAction()
                    }
                } else {
                    if scene.selectedTarget != nil {
                        scene.selectTarget(nil)
                    }
                    idleTicks = 0
                    scene.performTargetAction()
                }
            }
            try? await Task.sleep(for: .milliseconds(500))
        }
    }

    private var isUltraWidescreen: Bool {
        screenWidth >= 780
    }

    private var isWidescreen: Bool {
        screenWidth >= 640
    }

    private var chatBoxWidth: CGFloat {
        if isUltraWidescreen {
            360
        } else if isWidescreen {
            280
        } else {
            screenWidth - 16 * 2
        }
    }

    private var statusIconBarBottomPadding: CGFloat {
        if isWidescreen {
            16 + actionBarHeight + 8
        } else {
            ChatBoxView.contentHeight(for: .compact) + 8 + actionBarHeight + 8
        }
    }
}
