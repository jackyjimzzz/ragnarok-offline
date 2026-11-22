//
//  SkillEffectTable.swift
//  RagnarokEffects
//
//  Created by Leon Li on 2026/4/30.
//

import RagnarokConstants

// Ported from roBrowserLegacy:
// https://github.com/MrAntares/roBrowserLegacy/blob/master/src/DB/Skills/SkillEffect.js
public enum SkillEffectTable {
    // Keep entries sorted in ascending order by `SkillID.rawValue`.
    private static let table: [SkillID : SkillEffectDefinition] = [
        .sm_bash: .init(
            beginCastEffects: [.id(.ef_bash)],
            hitEffects: [.id(.ef_hit2)]
        ),
        .sm_provoke: .init(
            successEffects: [.id(.ef_provoke)]
        ),
        .sm_endure: .init(
            effects: [.id(.ef_endure)]
        ),
        .mg_lightningbolt: .init(
            effects: [.id(.ef_lightbolt)],
            hitEffects: [.id(.ef_windhit)]
        ),
        .mg_thunderstorm: .init(
            effects: [.id(.ef_thunderstorm)],
            hitEffects: [.id(.ef_windhit)]
        ),
        .mg_napalmbeat: .init(
            hitEffects: [.id(.ef_hit2)]
        ),
        .mg_soulstrike: .init(
            beforeHitEffects: [.id(.ef_soulstrike)],
            hitEffects: [.id(.ef_hit2)]
        ),
        .mg_coldbolt: .init(
            beforeHitEffects: [.name("ef_coldbolt")],
            hitEffects: [.id(.ef_coldhit)]
        ),
        .mg_frostdiver: .init(
            effects: [.id(.ef_frostdiver)],
            hitEffects: [.id(.ef_frostdiver2)]
        ),
        .mg_fireball: .init(
            beforeHitEffects: [.id(.ef_fireball)],
            hitEffects: [.id(.ef_firehit)]
        ),
        .mg_firebolt: .init(
            beforeHitEffects: [.name("ef_firebolt")],
            hitEffects: [.id(.ef_firehit)]
        ),
        .al_heal: .init(
            effects: [.id(.ef_heal)],
            hitEffects: [.id(.ef_heal3)]
        ),
        .al_incagi: .init(
            effects: [.id(.ef_incagility)]
        ),
        .al_decagi: .init(
            effects: [.id(.ef_decagility)]
        ),
        .al_holywater: .init(
            effects: [.id(.ef_aqua)]
        ),
        .al_crucis: .init(
            effects: [.id(.ef_signum)]
        ),
        .al_angelus: .init(
            effects: [.id(.ef_angelus)]
        ),
        .al_blessing: .init(
            effects: [.id(.ef_blessing)]
        ),
        .al_cure: .init(
            effects: [.id(.ef_cure)]
        ),
        .ac_concentration: .init(
            effects: [.id(.ef_concentration)]
        ),
        .ac_double: .init(
            beginCastEffects: [.id(.ef_bash)],
            beforeHitEffects: [.name("ef_arrow_projectile")],
            hitEffects: [.id(.ef_hit2)]
        ),
        .ac_shower: .init(
            effects: [.name("ef_arrow_shower_projectile")],
            hitEffects: [.id(.ef_hit2)]
        ),
        .all_resurrection: .init(
            effects: [.id(.ef_resurrection), .id(.ef_revive)]
        ),
        // [RagOff iPad Mod] Thief / Assassin / Guillotine Cross / Shadow Cross skills,
        // ported from roBrowserLegacy SkillEffect.js (effects that use the STR or WAV format).
        .as_cloaking: .init(
            effects: [.id(.ef_cloaking)]
        ),
        .as_sonicblow: .init(
            effects: [.id(.ef_sonicblow2)]
        ),
        .as_poisonreact: .init(
            effects: [.id(.ef_poisonreact)],
            hitEffects: [.id(.ef_poisonreact2)]
        ),
        .as_venomdust: .init(
            effects: [.id(.ef_venomdust)]
        ),
        .as_splasher: .init(
            effects: [.id(.ef_splasher)]
        ),
        .asc_edp: .init(
            effects: [.id(.ef_edp)]
        ),
        .gc_crossimpact: .init(
            effects: [.name("ef_gc_crossimpact")]
        ),
        .gc_poisoningweapon: .init(
            effects: [.name("ef_gc_poisoningweapon")]
        ),
        .gc_counterslash: .init(
            effects: [.name("ef_gc_counterslash")]
        ),
        .gc_poisonsmoke: .init(
            effects: [.name("ef_gc_poisonsmoke")]
        ),
        .gc_hallucinationwalk: .init(
            effects: [.name("ef_hallucinationwalk")]
        ),
        .gc_crossripperslasher: .init(
            effects: [.name("ef_gc_crossripperslasher")]
        ),
        .gc_darkcrow: .init(
            effects: [.id(.ef_gc_darkcrow)]
        ),
        .shc_shadow_exceed: .init(
            casterEffects: [.name("ef_shc_shadow_exceed_cast")]
        ),
        .shc_dancing_knife: .init(
            casterEffects: [.name("ef_shc_dancing_knife_cast")]
        ),
        .shc_savage_impact: .init(
            effects: [.name("ef_shc_savage_impact")],
            hitEffects: [.name("ef_shc_savage_impact_hit")]
        ),
        .shc_eternal_slash: .init(
            effects: [.name("ef_shc_eternal_slash")],
            hitEffects: [.name("ef_shc_eternal_slash_hit")]
        ),
        .shc_potent_venom: .init(
            effects: [.name("ef_shc_potent_venom")]
        ),
        .shc_shadow_stab: .init(
            effects: [.name("ef_shc_shadow_stab")]
        ),
        .shc_impact_crater: .init(
            effects: [.name("ef_shc_impact_crater")],
            hitEffects: [.name("ef_shc_impact_crater_hit")]
        ),
        .shc_enchanting_shadow: .init(
            effects: [.name("ef_shc_enchanting_shadow")]
        ),
        .shc_fatal_shadow_crow: .init(
            effects: [.name("ef_shc_fatal_shadow_crow")],
            hitEffects: [.name("ef_shc_fatal_shadow_crow_hit")]
        ),
    ]

    private static func entry(for skillID: SkillID) -> SkillEffectDefinition? {
        table[skillID] ?? RagOffSkillEffectTable.table[skillID] ?? RagOffSkillEffectTable2.table[skillID]
    }

    public static func beginCastEffects(for skillID: SkillID) -> [EffectReference] {
        entry(for: skillID)?.beginCastEffects ?? []
    }

    public static func effects(for skillID: SkillID) -> [EffectReference] {
        entry(for: skillID)?.effects ?? []
    }

    public static func beforeHitEffects(for skillID: SkillID) -> [EffectReference] {
        entry(for: skillID)?.beforeHitEffects ?? []
    }

    public static func hitEffects(for skillID: SkillID) -> [EffectReference] {
        entry(for: skillID)?.hitEffects ?? []
    }

    public static func successEffects(for skillID: SkillID) -> [EffectReference] {
        entry(for: skillID)?.successEffects ?? []
    }

    public static func casterEffects(for skillID: SkillID) -> [EffectReference] {
        entry(for: skillID)?.casterEffects ?? []
    }
}
