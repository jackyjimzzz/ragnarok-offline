//
//  RagOffMobileActionBarView.swift
//  RagnarokGame
//
//  [RagOff iPad Mod] Larger touch controls for iPad: big buttons, a 4 x 2 shortcut grid,
//  an auto hunt switch and an adjustable size. MapSceneView can switch back to the
//  original ActionBarView at any time.
//

import RagnarokModels
import SwiftUI

private let ragOffGray = Color(#colorLiteral(red: 0.7568627451, green: 0.7568627451, blue: 0.7568627451, alpha: 0.3296931004))
private let ragOffYellow = Color(#colorLiteral(red: 0.8877201569, green: 0.7630142746, blue: 0.3606613333, alpha: 0.55))
private let ragOffBlue = Color(#colorLiteral(red: 0.2155968627, green: 0.3285380392, blue: 0.5614792157, alpha: 0.55))
private let ragOffGreen = Color(#colorLiteral(red: 0.2328621177, green: 0.543450353, blue: 0.3646268235, alpha: 0.55))
private let ragOffRed = Color(#colorLiteral(red: 0.6283159216, green: 0.2047865098, blue: 0.1977276863, alpha: 0.7))
private let ragOffScaleSteps: [Double] = [0.85, 1.0, 1.15, 1.3]

struct RagOffMobileActionBarView: View {
    var selectedTargetType: MapObjectType?
    var isAutoHunting: Bool
    var onToggleAutoHunt: () -> Void
    var onTargetAction: () -> Void
    var onSelectNextTarget: () -> Void
    var onDeselectTarget: () -> Void
    var onPickup: () -> Void
    var onSit: () -> Void
    var onShortcut: (Shortcut) -> Void

    @Environment(PlaySession.self) private var playSession
    @AppStorage("ragOffControlScale") private var controlScale: Double = 1.0
    @State private var currentRow = 0

    private var scale: CGFloat {
        CGFloat(controlScale)
    }

    var body: some View {
        VStack(alignment: .trailing, spacing: 8) {
            HStack(spacing: 8) {
                if selectedTargetType != nil {
                    RagOffRoundButton(color: ragOffGray, size: 52 * scale, action: onDeselectTarget) {
                        RagOffSymbol(name: "xmark", size: 18 * scale)
                    }
                }
                RagOffRoundButton(color: isAutoHunting ? Color.orange.opacity(0.85) : ragOffGray, size: 52 * scale, action: onToggleAutoHunt) {
                    VStack(spacing: 1) {
                        RagOffSymbol(name: isAutoHunting ? "stop.fill" : "play.fill", size: 15 * scale)
                        Text(verbatim: isAutoHunting ? "停止" : "自動")
                            .font(.game(size: 10 * scale, weight: .bold))
                            .foregroundStyle(.white)
                    }
                }
                RagOffRoundButton(color: ragOffYellow, size: 52 * scale, action: onSelectNextTarget) {
                    RagOffSymbol(name: "scope", size: 18 * scale)
                }
                RagOffRoundButton(color: ragOffBlue, size: 52 * scale, action: onPickup) {
                    RagOffSymbol(name: "hand.wave", size: 18 * scale)
                }
                RagOffRoundButton(color: ragOffGreen, size: 52 * scale, action: onSit) {
                    RagOffSymbol(name: "figure.seated.side", size: 18 * scale)
                }
            }

            HStack(alignment: .bottom, spacing: 8) {
                VStack(spacing: 8) {
                    RagOffRoundButton(color: ragOffGray, size: 44 * scale, action: cycleScale) {
                        RagOffSymbol(name: "plus.magnifyingglass", size: 15 * scale)
                    }
                    RagOffRoundButton(color: ragOffGray, size: 44 * scale, action: turnRow) {
                        Text(verbatim: "\(row + 1)")
                            .font(.game(size: 16 * scale, weight: .bold))
                            .foregroundStyle(.white)
                    }
                }

                VStack(spacing: 6) {
                    HStack(spacing: 6) {
                        ForEach(0..<4, id: \.self) { column in
                            slotButton(column: column)
                        }
                    }
                    HStack(spacing: 6) {
                        ForEach(4..<8, id: \.self) { column in
                            slotButton(column: column)
                        }
                    }
                }
                .padding(6)
                .background(Color.black.opacity(0.35))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

                RagOffRoundButton(color: ragOffRed, size: 84 * scale, action: onTargetAction) {
                    switch selectedTargetType {
                    case .npc:
                        GameTalkIcon()
                            .frame(width: 36 * scale, height: 36 * scale)
                    default:
                        GameSwordIcon()
                            .frame(width: 40 * scale, height: 40 * scale)
                    }
                }
            }
        }
    }

    private func slotButton(column: Int) -> some View {
        let shortcut = playSession.shortcutList.rows[row][column]
        return RagOffSlotButton(shortcut: shortcut, size: 58 * scale) {
            onShortcut(shortcut)
        }
    }

    private var row: Int {
        let nonEmptyRows = playSession.shortcutList.nonEmptyRows
        if nonEmptyRows.contains(currentRow) {
            return currentRow
        }
        return nonEmptyRows.first ?? currentRow
    }

    private func turnRow() {
        let nonEmptyRows = playSession.shortcutList.nonEmptyRows
        guard nonEmptyRows.count > 1 else {
            return
        }
        currentRow = nonEmptyRows.first(where: { $0 > row }) ?? nonEmptyRows[0]
    }

    private func cycleScale() {
        let index = ragOffScaleSteps.firstIndex(where: { abs($0 - controlScale) < 0.01 }) ?? 1
        controlScale = ragOffScaleSteps[(index + 1) % ragOffScaleSteps.count]
    }
}

private struct RagOffSymbol: View {
    var name: String
    var size: CGFloat

    var body: some View {
        Image(systemName: name)
            .font(.game(size: size, weight: .bold))
            .foregroundStyle(.white)
    }
}

private struct RagOffRoundButton<Content>: View where Content: View {
    var color: Color
    var size: CGFloat
    var action: () -> Void
    @ViewBuilder var content: Content

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(color)
                content
            }
            .frame(width: size, height: size)
            .contentShape(Circle())
        }
        .buttonStyle(.plain)
    }
}

private struct RagOffSlotButton: View {
    var shortcut: Shortcut
    var size: CGFloat
    var action: () -> Void

    @Environment(PlaySession.self) private var playSession

    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(ragOffGray)

                ShortcutIconView(shortcut: shortcut)
                    .frame(width: size * 0.62, height: size * 0.62)
                    .opacity(playSession.isShortcutAvailable(shortcut) ? 1 : 0.4)
                    .overlay {
                        if let cooldown = playSession.skillCooldown(for: shortcut) {
                            SkillCooldownView(cooldown: cooldown)
                        }
                    }

                if let label = playSession.shortcutLabel(shortcut) {
                    Text(verbatim: label)
                        .font(.game(size: 12, weight: .bold))
                        .foregroundStyle(Color.white)
                        .shadow(color: .black, radius: 1)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                        .padding(3)
                }
            }
            .frame(width: size, height: size)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
