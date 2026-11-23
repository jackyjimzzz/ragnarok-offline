//
//  SkillListView.swift
//  RagnarokGame
//
//  Created by Leon Li on 2026/3/1.
//

import RagnarokConstants
import RagnarokCore
import RagnarokModels
import RagnarokResources
import SwiftUI

struct SkillListView: View {
    var skillList: SkillList
    var onClose: () -> Void = {}

    @Environment(PlaySession.self) private var playSession

    @State private var selectedSkillID: Int?

    var body: some View {
        VStack(spacing: 3) {
            GameWindow {
                // [RagOff iPad Mod] Skill tree layout: skills grouped by job, like the skill simulator.
                ScrollView {
                    LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                        ForEach(ragOffSkillGroups) { group in
                            Section {
                                ForEach(group.skills, id: \.skillID) { skill in
                                    SkillListRow(skill: skill, isSelected: (selectedSkillID == skill.skillID))
                                        .onTapGesture {
                                            selectedSkillID = skill.skillID
                                        }
                                        .shortcutDragSource(shortcut(for: skill))
                                }
                            } header: {
                                RagOffSkillGroupHeader(
                                    title: group.title,
                                    learnedCount: group.skills.filter { $0.level > 0 }.count,
                                    totalCount: group.skills.count
                                )
                            }
                        }
                    }
                }
                .frame(height: 380)
            } bottomBar: {
                GameBottomBar()
                    .overlay(alignment: .leading) {
                        Text(verbatim: "Skill Points: \(playSession.playerStatus.skillPoint)")
                            .font(.game())
                            .foregroundStyle(Color.gameProminentLabel)
                            .padding(.leading, 10)
                    }
            }
            .gameWindowTitle(Text("Skill List", bundle: #bundle))
            .gameWindowCloseAction(onClose)
            .geometryGroup()
            .blur(radius: selectedSkillID == nil ? 0 : 5)
            .frame(width: 400)
            .overlay {
                if selectedSkillID != nil {
                    Color.clear
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedSkillID = nil
                        }
                }
            }
            .overlay {
                contextMenu
                    .transition(.opacity.combined(with: .scale).animation(.bouncy(duration: 0.25, extraBounce: 0.2)))
            }

            ShortcutBarView()
        }
        .shortcutDragContainer()
        .animation(.easeInOut(duration: 0.25), value: selectedSkillID)
    }

    @ViewBuilder private var contextMenu: some View {
        if let selectedSkillID, let skill = skillList.skills[selectedSkillID] {
            VStack(alignment: .leading, spacing: 3) {
                SkillPreview(skill: skill)
                    .overlay(alignment: .topTrailing) {
                        GameCloseButton {
                            self.selectedSkillID = nil
                        }
                    }

                if skill.level > 0 && !skill.isPassiveSkill {
                    SkillActions(skill: skill) {
                        self.selectedSkillID = nil
                    }
                }
            }
            .padding(.vertical, 20)
        }
    }

    private var ragOffSkillGroups: [RagOffSkillGroup] {
        RagOffSkillGroup.groups(for: skillList.sortedSkills)
    }

    /// Only a learned, active skill can be put in the shortcut bar.
    private func shortcut(for skill: SkillInfo) -> Shortcut {
        if skill.level > 0 && !skill.isPassiveSkill {
            .skill(skillID: skill.skillID, level: skill.level)
        } else {
            .empty
        }
    }
}

private struct SkillListRow: View {
    var skill: SkillInfo
    var isSelected: Bool

    @Environment(GameContext.self) private var gameContext
    @Environment(PlaySession.self) private var playSession
    @Environment(\.upgradeSkillLevel) private var upgradeSkillLevel

    @State private var iconImage: Resources.Image?

    private var isDisabled: Bool {
        skill.level == 0
    }

    private var isUpgradable: Bool {
        skill.isUpgradable && playSession.playerStatus.skillPoint > 0
    }

    private var skillName: String {
        if let skillName = gameContext.skillInfoTable.localizedSkillName(forSkillID: skill.skillID) {
            skillName
        } else if let skillID = SkillID(rawValue: skill.skillID) {
            skillID.stringValue
        } else {
            "Skill \(skill.skillID)"
        }
    }

    private var skillLevel: String {
        if skill.maxLevel > 0 {
            "\(skill.level) / \(skill.maxLevel)"
        } else {
            "\(skill.level)"
        }
    }

    private var skillBackgroundColor: Color {
        if !isSelected {
            .clear
        } else if isDisabled {
            Color(#colorLiteral(red: 0.7098039216, green: 0.7098039216, blue: 0.7098039216, alpha: 1))
        } else if skill.isPassiveSkill {
            Color(#colorLiteral(red: 0.4509803922, green: 0.8352941176, blue: 0.9333333333, alpha: 1))
        } else {
            Color(#colorLiteral(red: 0.4509803922, green: 0.6117647059, blue: 0.9333333333, alpha: 1))
        }
    }

    var body: some View {
        HStack(spacing: 0) {
            HStack(spacing: 8) {
                ZStack {
                    if let iconImage {
                        Image(decorative: iconImage.cgImage, scale: 1)
                            .resizable()
                            .interpolation(.none)
                    }
                }
                .frame(width: 32, height: 32)

                VStack(alignment: .leading, spacing: 1) {
                    Text(skillName)
                        .font(.game())
                        .foregroundStyle(Color.gameLabel)
                        .lineLimit(1)

                    if !isDisabled {
                        Text(verbatim: "Lv: \(skillLevel)")
                            .font(.game(size: 11))
                            .foregroundStyle(Color.gameProminentLabel)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .opacity(isDisabled ? 0.5 : 1)
            .padding(.leading, 15)
            .padding(.trailing, 8)

            if !isDisabled {
                Text(verbatim: skill.isPassiveSkill ? "Passive" : "SP: \(skill.spCost)")
                    .font(.game(size: 11))
                    .foregroundStyle(Color.gameLabel)
                    .frame(width: 64, alignment: .trailing)
                    .padding(.trailing, 8)
            } else {
                Spacer(minLength: 0)
            }

            SkillUpgradeButton {
                upgradeSkillLevel?(skillID: skill.skillID)
            }
            .frame(width: 44, height: 40)
            .opacity(isUpgradable ? 1 : 0)
            .disabled(!isUpgradable)
            .padding(.trailing, 2)
        }
        .frame(height: 48)
        .background(skillBackgroundColor)
        .contentShape(Rectangle())
        .task(id: skill.skillID) {
            guard let skillID = SkillID(rawValue: skill.skillID) else {
                return
            }

            let path = ResourcePath.generateSkillIconImagePath(skillAegisName: skillID.stringValue)
            iconImage = try? await gameContext.resourceManager.image(at: path, removesMagentaPixels: true)
        }
    }
}

private struct SkillUpgradeButton: View {
    var action: () -> Void

    var body: some View {
        // basic_interface/skill_up_a.bmp
        Button(action: action) {
            ZStack {
                SkillUpgradeTrendShape()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(#colorLiteral(red: 0.4392156863, green: 0.5490196078, blue: 0.8156862745, alpha: 1)),
                                Color(#colorLiteral(red: 0.3764705882, green: 0.5019607843, blue: 0.7843137255, alpha: 1)),
                                Color(#colorLiteral(red: 0.6588235294, green: 0.7215686275, blue: 0.8784313725, alpha: 1)),
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )

                Text(verbatim: "Lv UP")
                    .font(.game(size: 6.5, weight: .black))
                    .tracking(-0.15)
                    .foregroundStyle(Color.gameLabel)
                    .offset(y: 5.5)
            }
            .frame(width: 24, height: 24)
        }
        .buttonStyle(.game)
        .frame(width: 24, height: 24)
        // [RagOff iPad Mod] Bigger "Lv UP" button for fingers.
        .scaleEffect(1.5)
        .frame(width: 40, height: 40)
        .contentShape(Rectangle())
    }
}

private struct SkillUpgradeTrendShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 3, y: 13))
        path.addLine(to: CGPoint(x: 10.5, y: 5.5))
        path.addQuadCurve(to: CGPoint(x: 11.5, y: 5.5), control: CGPoint(x: 11, y: 5))
        path.addLine(to: CGPoint(x: 15.5, y: 9.5))
        path.addLine(to: CGPoint(x: 18.875, y: 6.125))
        path.addLine(to: CGPoint(x: 17, y: 4.25))
        path.addLine(to: CGPoint(x: 22, y: 4.25))
        path.addLine(to: CGPoint(x: 22, y: 9.25))
        path.addLine(to: CGPoint(x: 20.125, y: 7.375))
        path.addLine(to: CGPoint(x: 16.2, y: 11.3))
        path.addQuadCurve(to: CGPoint(x: 14.8, y: 11.3), control: CGPoint(x: 15.5, y: 12))
        path.addLine(to: CGPoint(x: 11, y: 7.5))
        path.addLine(to: CGPoint(x: 8.5, y: 13))
        path.closeSubpath()
        return path.applying(CGAffineTransform(scaleX: rect.width / 24, y: rect.height / 24))
    }
}

private struct SkillPreview: View {
    var skill: SkillInfo

    @Environment(GameContext.self) private var gameContext

    var body: some View {
        ScrollView {
            Text(AttributedString(description: description, defaultColor: .gameLabel))
                .font(.game())
                .lineSpacing(5)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(5)
        .frame(width: 280)
        .background(RoundedRectangle(cornerRadius: 5, style: .circular).fill(Material.bar))
        .overlay {
            RoundedRectangle(cornerRadius: 3, style: .circular)
                .stroke(Color.gameBoxBorder, lineWidth: 1)
                .padding(2)
        }
    }

    private var description: String {
        if let description = gameContext.skillInfoTable.localizedSkillDescription(forSkillID: skill.skillID) {
            description
        } else if let skillID = SkillID(rawValue: skill.skillID) {
            skillID.stringValue
        } else {
            "Skill \(skill.skillID)"
        }
    }
}

private struct SkillActions: View {
    var skill: SkillInfo
    var dismiss: () -> Void

    @Environment(PlaySession.self) private var playSession

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            GameContextMenuButton {
                playSession.useShortcut(.skill(skillID: skill.skillID, level: skill.level))
                dismiss()
            } label: {
                Text("Use", bundle: #bundle)
            }
        }
        .frame(width: 120)
        .background(RoundedRectangle(cornerRadius: 5, style: .circular).fill(Material.bar))
        .overlay {
            RoundedRectangle(cornerRadius: 3, style: .circular)
                .stroke(Color.gameBoxBorder, lineWidth: 1)
                .padding(2)
        }
    }
}

#Preview {
    let playSession = {
        let playSession = PlaySession(context: .testing)

        playSession.playerStatus.skillPoint = 1

        var bash = SkillInfo()
        bash.skillID = 5
        bash.flag = SkillInfoFlag.attack.rawValue
        bash.level = 5
        bash.spCost = 8
        bash.attackRange = 1
        bash.isUpgradable = true
        bash.maxLevel = 10
        playSession.skillList.skills[5] = bash

        var heal = SkillInfo()
        heal.skillID = 28
        heal.flag = SkillInfoFlag.support.rawValue
        heal.level = 10
        heal.spCost = 40
        heal.attackRange = 9
        heal.isUpgradable = false
        heal.maxLevel = 10
        playSession.skillList.skills[28] = heal

        var swordMastery = SkillInfo()
        swordMastery.skillID = 2
        swordMastery.flag = SkillInfoFlag.passive.rawValue
        swordMastery.level = 10
        swordMastery.spCost = 0
        swordMastery.attackRange = 0
        swordMastery.isUpgradable = false
        swordMastery.maxLevel = 10
        playSession.skillList.skills[2] = swordMastery

        return playSession
    }()

    SkillListView(skillList: playSession.skillList)
        .padding()
        .environment(GameContext.testing)
        .environment(playSession)
}

// MARK: - [RagOff iPad Mod] Skill tree groups

private struct RagOffSkillGroup: Identifiable {
    var id: String
    var title: String
    var order: Int
    var skills: [SkillInfo]

    static func groups(for skills: [SkillInfo]) -> [RagOffSkillGroup] {
        var groupsByID: [String : RagOffSkillGroup] = [:]
        for skill in skills {
            let prefix: String
            if let skillID = SkillID(rawValue: skill.skillID) {
                prefix = String(skillID.stringValue.uppercased().split(separator: "_").first ?? "")
            } else {
                prefix = ""
            }
            let title = ragOffSkillGroupTitles[prefix]
            let groupID = title == nil ? "OTHER" : prefix
            if groupsByID[groupID] == nil {
                groupsByID[groupID] = RagOffSkillGroup(
                    id: groupID,
                    title: title ?? "其他技能",
                    order: title == nil ? Int.max : skill.skillID,
                    skills: []
                )
            }
            groupsByID[groupID]?.skills.append(skill)
            if title != nil, let current = groupsByID[groupID], skill.skillID < current.order {
                groupsByID[groupID]?.order = skill.skillID
            }
        }
        return groupsByID.values.sorted {
            $0.order != $1.order ? $0.order < $1.order : $0.id < $1.id
        }
    }
}

private let ragOffSkillGroupTitles: [String : String] = [
    "NV": "初學者", "SM": "劍士", "MG": "魔法師", "AC": "弓箭手", "AL": "服事", "MC": "商人", "TF": "盜賊",
    "KN": "騎士", "CR": "十字軍／創造者", "WZ": "巫師", "SA": "賢者", "HT": "獵人", "BA": "詩人", "DC": "舞孃",
    "BD": "合奏技能", "PR": "祭司", "MO": "武僧", "BS": "鐵匠", "AM": "鍊金術師", "AS": "刺客", "RG": "流氓",
    "LK": "騎士領主", "PA": "聖殿十字軍", "HW": "超魔導士", "PF": "智者", "SN": "神射手", "CG": "搞笑藝人／冷豔舞姬",
    "HP": "神官", "CH": "武術宗師", "WS": "神工匠", "ASC": "十字刺客", "ST": "神行太保",
    "TK": "跆拳", "SG": "拳聖", "SL": "悟靈士", "SJ": "星帝", "SP": "魂靈師", "GS": "槍手", "RL": "反叛者",
    "NJ": "忍者", "KO": "影狼／朧", "KG": "影狼", "OB": "朧", "SU": "喵族",
    "RK": "盧恩騎士", "LG": "皇家禁衛隊", "WL": "咒術士", "SO": "妖術師", "RA": "遊俠", "WM": "漫遊者／宮廷樂師",
    "MI": "宮廷樂師", "WA": "漫遊者", "AB": "大主教", "SR": "修羅", "NC": "機械工匠", "GN": "基因學者",
    "GC": "十字斬首者", "SC": "魅影追蹤者",
    "DK": "盧恩龍爵", "IG": "帝國聖衛軍", "AG": "禁咒魔導士", "EM": "元素支配者", "WH": "風鷹狩獵者",
    "TR": "天籟頌者／樂之舞靈", "CD": "樞機主教", "IQ": "聖裁者", "MT": "機甲神匠", "BO": "生命締造者",
    "SHC": "十字影武", "ABC": "深淵追跡者",
    "SKE": "天帝", "SOA": "魂靈苦行者", "SH": "喵族四轉", "SS": "蜃氣樓／幻朧", "NW": "夜行者", "HN": "極限初學者",
    "ALL": "通用技能",
]

private struct RagOffSkillGroupHeader: View {
    var title: String
    var learnedCount: Int
    var totalCount: Int

    var body: some View {
        HStack {
            Text(verbatim: title)
                .font(.game(size: 13, weight: .bold))
                .foregroundStyle(Color.gameProminentLabel)
            Spacer()
            Text(verbatim: "\(learnedCount) / \(totalCount)")
                .font(.game(size: 11))
                .foregroundStyle(Color.gameLabel)
        }
        .padding(.horizontal, 12)
        .frame(height: 28)
        .background(Color(#colorLiteral(red: 0.8705882353, green: 0.9098039216, blue: 0.9725490196, alpha: 1)))
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(Color.gameBoxBorder)
                .frame(height: 1)
        }
    }
}
