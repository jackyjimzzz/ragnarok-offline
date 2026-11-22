//
//  SkillEffectTable+RagOff2.swift
//  RagnarokEffects
//
//  [RagOff iPad Mod] Extra skill effects for the remaining classes and monsters.
//  Converted automatically from roBrowserLegacy SkillEffect.js
//  (https://github.com/MrAntares/roBrowserLegacy/blob/master/src/DB/Skills/SkillEffect.js).
//

import RagnarokConstants

enum RagOffSkillEffectTable2 {
    static let table: [SkillID : SkillEffectDefinition] = {
        var table: [SkillID : SkillEffectDefinition] = [:]
        for chunk in [skills0, skills1, skills2, skills3, skills4, skills5] {
            table.merge(chunk) { first, _ in first }
        }
        return table
    }()

    private static let skills0: [SkillID : SkillEffectDefinition] = [
        .abc_abyss_dagger: .init(
            effects: [.name("ef_abc_abyss_dagger")],
            hitEffects: [.name("ef_abc_abyss_dagger_hit")]
        ),
        .abc_abyss_slayer: .init(
            effects: [.name("ef_abc_abyss_slayer")],
            casterEffects: [.name("ef_abc_abyss_slayer_cast")]
        ),
        .abc_abyss_square: .init(
            effects: [.name("ef_abc_abyss_square")],
            hitEffects: [.name("ef_abc_abyss_square_hit")]
        ),
        .abc_abyss_strike: .init(
            effects: [.name("ef_abc_abyss_strike")],
            hitEffects: [.name("ef_abc_abyss_strike_hit")],
            casterEffects: [.name("ef_abc_abyss_strike_cast")]
        ),
        .abc_chain_reaction_shot: .init(
            effects: [.name("ef_abc_chain_reaction_shot")],
            hitEffects: [.name("ef_abc_chain_reaction_shot_hit")],
            casterEffects: [.name("ef_abc_chain_reaction_shot_cast")]
        ),
        .abc_chain_reaction_shot_atk: .init(
            effects: [.name("ef_abc_chain_reaction_shot_atk")]
        ),
        .abc_deft_stab: .init(
            effects: [.name("ef_abc_deft_stab")]
        ),
        .abc_frenzy_shot: .init(
            effects: [.name("ef_abc_frenzy_shot")],
            hitEffects: [.name("ef_abc_frenzy_shot_hit")]
        ),
        .abc_from_the_abyss: .init(
            hitEffects: [.name("ef_abc_from_the_abyss_hit")]
        ),
        .abc_from_the_abyss_atk: .init(
            effects: [.name("ef_abc_from_the_abyss_atk")]
        ),
        .abc_unlucky_rush: .init(
            effects: [.name("ef_abc_unlucky_rush")],
            hitEffects: [.name("ef_abc_unlucky_rush_hit")],
            casterEffects: [.name("ef_abc_unlucky_rush_cast")]
        ),
        .ag_all_bloom: .init(
            effects: [.name("ef_ag_all_bloom")],
            hitEffects: [.name("ef_ag_all_bloom_hit")],
            casterEffects: [.name("ef_ag_all_bloom_cast")]
        ),
        .ag_all_bloom_atk: .init(
            effects: [.name("ef_ag_all_bloom_atk")]
        ),
        .ag_all_bloom_atk2: .init(
            effects: [.name("ef_ag_all_bloom_atk2")]
        ),
        .ag_astral_strike: .init(
            effects: [.name("ef_ag_astral_strike")],
            casterEffects: [.name("ef_ag_astral_strike_cast")]
        ),
        .ag_climax: .init(
            effects: [.name("ef_ag_climax")],
            casterEffects: [.name("ef_ag_climax_cast")]
        ),
        .ag_crimson_arrow: .init(
            effects: [.name("ef_ag_crimson_arrow")],
            hitEffects: [.name("ef_ag_crimson_arrow_hit")],
            casterEffects: [.name("ef_ag_crimson_arrow_cast")]
        ),
        .ag_crimson_arrow_atk: .init(
            effects: [.name("ef_ag_crimson_arrow_atk")]
        ),
        .ag_crystal_impact: .init(
            effects: [.name("ef_ag_crystal_impact")],
            hitEffects: [.name("ef_ag_crystal_impact_hit")],
            casterEffects: [.name("ef_ag_crystal_impact_cast")]
        ),
        .ag_crystal_impact_atk: .init(
            effects: [.name("ef_ag_crystal_impact_atk")]
        ),
        .ag_deadly_projection: .init(
            hitEffects: [.name("ef_ag_deadly_projection_hit")],
            casterEffects: [.name("ef_ag_deadly_projection_cast")]
        ),
        .ag_destructive_hurricane: .init(
            effects: [.name("ef_ag_destructive_hurricane")],
            hitEffects: [.name("ef_ag_destructive_hurricane_hit")],
            casterEffects: [.name("ef_ag_destructive_hurricane_cast")]
        ),
        .ag_frozen_slash: .init(
            effects: [.name("ef_ag_frozen_slash")],
            hitEffects: [.name("ef_ag_frozen_slash_hit")],
            casterEffects: [.name("ef_ag_frozen_slash_cast")]
        ),
        .ag_mystery_illusion: .init(
            effects: [.name("ef_ag_mystery_illusion")],
            hitEffects: [.name("ef_ag_mystery_illusion_hit")],
            casterEffects: [.name("ef_ag_mystery_illusion_cast")]
        ),
        .ag_rain_of_crystal: .init(
            hitEffects: [.name("ef_ag_rain_of_crystal_hit")],
            casterEffects: [.name("ef_ag_rain_of_crystal_cast")]
        ),
        .ag_rock_down: .init(
            effects: [.name("ef_ag_rock_down")],
            hitEffects: [.name("ef_ag_rock_down_hit")],
            casterEffects: [.name("ef_ag_rock_down_cast")]
        ),
        .ag_soul_vc_strike: .init(
            hitEffects: [.name("ef_ag_soul_vc_strike_hit")],
            casterEffects: [.name("ef_ag_soul_vc_strike_cast")]
        ),
        .ag_storm_cannon: .init(
            effects: [.name("ef_ag_storm_cannon")],
            casterEffects: [.name("ef_ag_storm_cannon_cast")]
        ),
        .ag_strantum_tremor: .init(
            effects: [.name("ef_ag_strantum_tremor")],
            hitEffects: [.name("ef_ag_strantum_tremor_hit")],
            casterEffects: [.name("ef_ag_strantum_tremor_cast")]
        ),
        .ag_tornado_storm: .init(
            effects: [.name("ef_ag_tornado_storm")],
            hitEffects: [.name("ef_ag_tornado_storm_hit")],
            casterEffects: [.name("ef_ag_tornado_storm_cast")]
        ),
        .ag_violent_quake: .init(
            effects: [.name("ef_ag_violent_quake")],
            hitEffects: [.name("ef_ag_violent_quake_hit")],
            casterEffects: [.name("ef_ag_violent_quake_cast")]
        ),
        .ag_violent_quake_atk: .init(
            effects: [.name("ef_ag_violent_quake_atk")]
        ),
        .all_full_throttle: .init(
            effects: [.id(.ef_all_full_throttle)]
        ),
        .all_wewish: .init(
            effects: [.id(.ef_wewish)]
        ),
        .am_acidterror: .init(
            beforeHitEffects: [.id(.ef_throwitem)]
        ),
        .am_berserkpitcher: .init(
            effects: [.id(.ef_potion_berserk)]
        ),
        .am_cp_armor: .init(
            effects: [.id(.ef_chemicalprotection)]
        ),
        .am_cp_helm: .init(
            effects: [.id(.ef_chemicalprotection)]
        ),
        .am_cp_shield: .init(
            effects: [.id(.ef_chemicalprotection)]
        ),
        .am_cp_weapon: .init(
            effects: [.id(.ef_chemicalprotection)]
        ),
        .am_demonstration: .init(
            effects: [.id(.ef_demonstration)]
        ),
        .bo_acidified_zone_fire: .init(
            hitEffects: [.name("ef_bo_acidified_zone_fire_hit")],
            casterEffects: [.name("ef_bo_acidified_zone_fire_cast")]
        ),
        .bo_acidified_zone_ground: .init(
            hitEffects: [.name("ef_bo_acidified_zone_ground_hit")],
            casterEffects: [.name("ef_bo_acidified_zone_ground_cast")]
        ),
        .bo_acidified_zone_water: .init(
            hitEffects: [.name("ef_bo_acidified_zone_water_hit")],
            casterEffects: [.name("ef_bo_acidified_zone_water_cast")]
        ),
        .bo_acidified_zone_wind: .init(
            hitEffects: [.name("ef_bo_acidified_zone_wind_hit")],
            casterEffects: [.name("ef_bo_acidified_zone_wind_cast")]
        ),
        .bo_advance_protection: .init(
            effects: [.name("ef_bo_advance_protection")]
        ),
        .bo_explosive_powder: .init(
            effects: [.name("ef_bo_explosive_powder")]
        ),
        .bo_helltree: .init(
            casterEffects: [.name("ef_bo_helltree_cast")]
        ),
        .bo_mayhemic_thorns: .init(
            effects: [.name("ef_bo_mayhemic_thorns")]
        ),
        .bo_researchreport: .init(
            effects: [.name("ef_bo_researchreport")],
            casterEffects: [.name("ef_bo_researchreport_cast")]
        ),
        .bo_wooden_fairy: .init(
            casterEffects: [.name("ef_bo_wooden_fairy_cast")]
        ),
        .bo_woodenwarrior: .init(
            hitEffects: [.name("ef_bo_woodenwarrior_hit")],
            casterEffects: [.name("ef_bo_woodenwarrior_cast")]
        ),
        .bs_adrenaline: .init(
            beginCastEffects: [.name("98_beforecast")],
            effects: [.id(.ef_hasteup)]
        ),
        .bs_adrenaline2: .init(
            effects: [.name("ef_bs_adrenaline2")]
        ),
        .bs_greed: .init(
            effects: [.name("ef_greed_sound")]
        ),
        .bs_hammerfall: .init(
            effects: [.id(.ef_crashearth)]
        ),
        .bs_maximize: .init(
            effects: [.id(.ef_maxpower)]
        ),
        .bs_overthrust: .init(
            effects: [.id(.ef_overthrust)]
        ),
        .bs_repairweapon: .init(
            effects: [.id(.ef_repairweapon)]
        ),
        .bs_weaponperfect: .init(
            effects: [.id(.ef_perfection)]
        ),
        .em_activity_burn: .init(
            effects: [.name("ef_em_activity_burn")],
            casterEffects: [.name("ef_em_activity_burn_cast")]
        ),
        .em_conflagration: .init(
            effects: [.name("ef_em_conflagration")],
            hitEffects: [.name("ef_em_conflagration_hit")],
            casterEffects: [.name("ef_em_conflagration_cast")]
        ),
        .em_diamond_storm: .init(
            effects: [.name("ef_em_diamond_storm")],
            hitEffects: [.name("ef_em_diamond_storm_hit")],
            casterEffects: [.name("ef_em_diamond_storm_cast")]
        ),
        .em_el_cold_force: .init(
            effects: [.name("ef_em_el_cold_force")]
        ),
        .em_el_deadly_poison: .init(
            effects: [.name("ef_em_el_deadly_poison")]
        ),
        .em_el_deep_poisoning: .init(
            effects: [.name("ef_em_el_deep_poisoning")]
        ),
        .em_el_earth_care: .init(
            effects: [.name("ef_em_el_earth_care")]
        ),
        .em_el_flamearmor: .init(
            effects: [.name("ef_em_el_flamearmor")]
        ),
        .em_el_flametechnic: .init(
            effects: [.name("ef_em_el_flametechnic")]
        ),
        .em_el_grace_breeze: .init(
            effects: [.name("ef_em_el_grace_breeze")]
        ),
        .em_elemental_buster: .init(
            casterEffects: [.name("ef_em_elemental_buster_cast")]
        ),
        .em_elemental_buster_fire: .init(
            effects: [.name("ef_em_elemental_buster_fire")],
            hitEffects: [.name("ef_em_elemental_buster_fire_hit")]
        ),
        .em_elemental_buster_ground: .init(
            effects: [.name("ef_em_elemental_buster_ground")],
            hitEffects: [.name("ef_em_elemental_buster_ground_hit")]
        ),
        .em_elemental_buster_poison: .init(
            effects: [.name("ef_em_elemental_buster_poison")],
            hitEffects: [.name("ef_em_elemental_buster_poison_hit")]
        ),
        .em_elemental_buster_water: .init(
            effects: [.name("ef_em_elemental_buster_water")],
            hitEffects: [.name("ef_em_elemental_buster_water_hit")]
        ),
        .em_elemental_buster_wind: .init(
            effects: [.name("ef_em_elemental_buster_wind")],
            hitEffects: [.name("ef_em_elemental_buster_wind_hit")]
        ),
        .em_increasing_activity: .init(
            effects: [.name("ef_em_increasing_activity")],
            casterEffects: [.name("ef_em_increasing_activity_cast")]
        ),
        .em_lightning_land: .init(
            effects: [.name("ef_em_lightning_land")],
            hitEffects: [.name("ef_em_lightning_land_hit")],
            casterEffects: [.name("ef_em_lightning_land_cast")]
        ),
        .em_spell_enchanting: .init(
            effects: [.name("ef_em_spell_enchanting")]
        ),
        .em_summon_elemental_ardor: .init(
            effects: [.name("ef_em_summon_elemental_ardor")],
            hitEffects: [.name("ef_em_summon_elemental_ardor_hit")],
            casterEffects: [.name("ef_em_summon_elemental_ardor_cast")]
        ),
    ]

    private static let skills1: [SkillID : SkillEffectDefinition] = [
        .em_summon_elemental_diluvio: .init(
            hitEffects: [.name("ef_em_summon_elemental_diluvio_hit")],
            casterEffects: [.name("ef_em_summon_elemental_diluvio_cast")]
        ),
        .em_summon_elemental_procella: .init(
            effects: [.name("ef_em_summon_elemental_procella")],
            hitEffects: [.name("ef_em_summon_elemental_procella_hit")],
            casterEffects: [.name("ef_em_summon_elemental_procella_cast")]
        ),
        .em_summon_elemental_serpens: .init(
            effects: [.name("ef_em_summon_elemental_serpens")],
            hitEffects: [.name("ef_em_summon_elemental_serpens_hit")],
            casterEffects: [.name("ef_em_summon_elemental_serpens_cast")]
        ),
        .em_summon_elemental_terremotus: .init(
            effects: [.name("ef_em_summon_elemental_terremotus")],
            hitEffects: [.name("ef_em_summon_elemental_terremotus_hit")],
            casterEffects: [.name("ef_em_summon_elemental_terremotus_cast")]
        ),
        .em_terra_drive: .init(
            effects: [.name("ef_em_terra_drive")],
            hitEffects: [.name("ef_em_terra_drive_hit")],
            casterEffects: [.name("ef_em_terra_drive_cast")]
        ),
        .em_venom_swamp: .init(
            effects: [.name("ef_em_venom_swamp")],
            hitEffects: [.name("ef_em_venom_swamp_hit")],
            casterEffects: [.name("ef_em_venom_swamp_cast")]
        ),
        .gn_cart_tornado: .init(
            effects: [.name("ef_gn_cart_tornado")]
        ),
        .gn_cartboost: .init(
            effects: [.name("ef_gn_cartboost")]
        ),
        .gn_cartcannon: .init(
            effects: [.name("ef_gn_cartcannon")],
            casterEffects: [.name("ef_gn_cartcannon_cast")]
        ),
        .gn_changematerial: .init(
            effects: [.name("ef_gn_changematerial")]
        ),
        .gn_illusiondoping: .init(
            effects: [.id(.ef_gn_illusiondoping)]
        ),
        .gn_mandragora: .init(
            effects: [.name("ef_gn_mandragora")],
            casterEffects: [.name("ef_gn_mandragora_cast")]
        ),
        .gn_thorns_trap: .init(
            effects: [.name("ef_thorntrap")]
        ),
        .gn_wallofthorn: .init(
            casterEffects: [.name("ef_gn_wallofthorn_cast")]
        ),
        .gs_bullseye: .init(
            effects: [.id(.ef_bullseye)]
        ),
        .gs_desperado: .init(
            effects: [.id(.ef_desperado)]
        ),
        .gs_disarm: .init(
            effects: [.id(.ef_rg_coin3)]
        ),
        .gs_dust: .init(
            effects: [.id(.ef_bash3d5)]
        ),
        .gs_glittering: .init(
            effects: [.name("gunslinger_coin")]
        ),
        .gs_increasing: .init(
            effects: [.id(.ef_agiup), .name("ef_gs_increasing")],
            casterEffects: [.name("ef_gs_increasing_cast")]
        ),
        .gs_magicalbullet: .init(
            effects: [.id(.ef_magicalbullet)]
        ),
        .gs_rapidshower: .init(
            effects: [.id(.ef_rapidshower)]
        ),
        .gs_tracking: .init(
            effects: [.id(.ef_trackcasting)],
            hitEffects: [.id(.ef_tracking)]
        ),
        .gs_tripleaction: .init(
            effects: [.id(.ef_tripleaction)]
        ),
        .hami_bloodlust: .init(
            effects: [.id(.ef_hamiblood)]
        ),
        .hami_castle: .init(
            effects: [.id(.ef_hamicastle)]
        ),
        .hami_defence: .init(
            effects: [.id(.ef_hamidefence)]
        ),
        .hn_breakinglimit: .init(
            effects: [.name("ef_hn_breakinglimit")]
        ),
        .hn_doublebowlingbash: .init(
            effects: [.name("ef_hn_doublebowlingbash")]
        ),
        .hn_hells_drive: .init(
            effects: [.name("ef_hn_hells_drive")]
        ),
        .hn_jupitel_thunder_storm: .init(
            effects: [.name("ef_hn_jupitel_thunder_storm")]
        ),
        .hn_mega_sonic_blow: .init(
            effects: [.name("ef_hn_mega_sonic_blow")]
        ),
        .hn_meteor_storm_buster: .init(
            effects: [.name("ef_hn_meteor_storm_buster")]
        ),
        .hn_napalm_vulcan_strike: .init(
            effects: [.name("ef_hn_napalm_vulcan_strike")]
        ),
        .hn_rulebreak: .init(
            effects: [.name("ef_hn_rulebreak")]
        ),
        .hn_shield_chain_rush: .init(
            effects: [.name("ef_hn_shield_chain_rush")]
        ),
        .hn_spiral_pierce_max: .init(
            effects: [.name("ef_hn_spiral_pierce_max")]
        ),
        .hp_basilica: .init(
            effects: [.id(.ef_bottom_basilica)]
        ),
        .hvan_explosion: .init(
            effects: [.id(.ef_sui_explosion)]
        ),
        .hw_magicpower: .init(
            beginCastEffects: [.id(.ef_bash)],
            effects: [.name("ef_magicpower")]
        ),
        .itm_tomahawk: .init(
            beforeHitEffects: [.name("ef_tomahawk_projectile")]
        ),
        .ko_jyumonjikiri: .init(
            effects: [.name("ef_ko_jyumonjikiri")]
        ),
        .ko_setsudan: .init(
            effects: [.name("ef_ko_setsudan")]
        ),
        .mc_cartrevolution: .init(
            beginCastEffects: [.id(.ef_cartrevolution)],
            hitEffects: [.id(.ef_cartrevolution)]
        ),
        .mc_loud: .init(
            effects: [.id(.ef_loud)]
        ),
        .mc_mammonite: .init(
            effects: [.id(.ef_coin)]
        ),
        .mg_energycoat: .init(
            casterEffects: [.id(.ef_energycoat)]
        ),
        .mg_firewall: .init(
            effects: [.id(.ef_firewall)],
            hitEffects: [.id(.ef_firehit)]
        ),
        .mg_stonecurse: .init(
            successEffects: [.id(.ef_stonecurse), .name("stonecurse_sound")]
        ),
        .mh_eraser_cutter: .init(
            effects: [.id(.ef_eraser_cutter)]
        ),
        .mh_lava_slide: .init(
            effects: [.id(.ef_lava_slide)]
        ),
        .mh_midnight_frenzy: .init(
            effects: [.id(.ef_midnight_frenzy)]
        ),
        .mh_poison_mist: .init(
            effects: [.id(.ef_poison_mist)]
        ),
        .mh_sonic_craw: .init(
            effects: [.id(.ef_sonic_claw)]
        ),
        .mh_tinder_breaker: .init(
            effects: [.id(.ef_tinder_breaker)]
        ),
        .mh_volcanic_ash: .init(
            effects: [.id(.ef_volcanic_ash)]
        ),
        .mo_extremityfist: .init(
            beginCastEffects: [.id(.ef_beginspell)],
            hitEffects: [.id(.ef_teihit1x)]
        ),
        .mt_a_machine: .init(
            effects: [.name("ef_mt_a_machine")],
            hitEffects: [.name("ef_mt_a_machine_hit")],
            casterEffects: [.name("ef_mt_a_machine_cast")]
        ),
        .mt_axe_stomp: .init(
            effects: [.name("ef_mt_axe_stomp")],
            hitEffects: [.name("ef_mt_axe_stomp_hit")]
        ),
        .mt_d_machine: .init(
            effects: [.name("ef_mt_d_machine")],
            casterEffects: [.name("ef_mt_d_machine_cast")]
        ),
        .mt_mighty_smash: .init(
            effects: [.name("ef_mt_mighty_smash")]
        ),
        .mt_rush_quake: .init(
            effects: [.name("ef_mt_rush_quake")],
            hitEffects: [.name("ef_mt_rush_quake_hit")]
        ),
        .mt_spark_blaster: .init(
            effects: [.name("ef_mt_spark_blaster")]
        ),
        .mt_summon_abr_battle_warior: .init(
            effects: [.name("ef_mt_summon_abr_battle_warior")]
        ),
        .mt_summon_abr_dual_cannon: .init(
            effects: [.name("ef_mt_summon_abr_dual_cannon")]
        ),
        .mt_summon_abr_infinity: .init(
            effects: [.name("ef_mt_summon_abr_infinity")],
            hitEffects: [.name("ef_mt_summon_abr_infinity_hit")],
            casterEffects: [.name("ef_mt_summon_abr_infinity_cast")]
        ),
        .mt_triple_laser: .init(
            effects: [.name("ef_mt_triple_laser")]
        ),
        .nc_armscannon: .init(
            casterEffects: [.name("ef_nc_armscannon_cast")]
        ),
        .nc_axeboomerang: .init(
            effects: [.name("ef_nc_axeboomerang")],
            hitEffects: [.name("ef_nc_axeboomerang_hit")],
            casterEffects: [.name("ef_nc_axeboomerang_cast")]
        ),
        .nc_axetornado: .init(
            effects: [.name("ef_nc_axetornado")]
        ),
        .nc_magma_eruption: .init(
            effects: [.id(.ef_nc_magma_eruption)]
        ),
        .nc_powerswing: .init(
            effects: [.id(.ef_crashaxe)]
        ),
        .nc_repair: .init(
            effects: [.name("ef_nc_repair")]
        ),
        .nc_vulcanarm: .init(
            effects: [.name("ef_nc_vulcanarm")]
        ),
        .nj_bakuenryu: .init(
            effects: [.id(.ef_baku)]
        ),
        .nj_huujin: .init(
            effects: [.id(.ef_stin4)]
        ),
        .nj_huuma: .init(
            beforeHitEffects: [.id(.ef_throwitem9)]
        ),
        .nj_hyousensou: .init(
            effects: [.id(.ef_hyousensou)]
        ),
        .nj_hyousyouraku: .init(
            effects: [.id(.ef_hyousyouraku)]
        ),
        .nj_issen: .init(
            effects: [.id(.ef_issen)]
        ),
    ]

    private static let skills2: [SkillID : SkillEffectDefinition] = [
        .nj_kaensin: .init(
            effects: [.id(.ef_kaen)]
        ),
        .nj_kasumikiri: .init(
            effects: [.id(.ef_kasumikiri)]
        ),
        .nj_kirikage: .init(
            effects: [.id(.ef_kirikage)]
        ),
        .nj_kouenka: .init(
            effects: [.id(.ef_kouenka)]
        ),
        .nj_kunai: .init(
            beforeHitEffects: [.id(.ef_throwitem8)]
        ),
        .nj_raigekisai: .init(
            effects: [.id(.ef_thunderstorm2)]
        ),
        .nj_syuriken: .init(
            beforeHitEffects: [.id(.ef_throwitem7)]
        ),
        .nj_tatamigaeshi: .init(
            effects: [.id(.ef_tatami)]
        ),
        .nj_zenynage: .init(
            beforeHitEffects: [.id(.ef_throwitem10)]
        ),
        .npc_criticalslash: .init(
            casterEffects: [.id(.ef_bash)]
        ),
        .npc_criticalwound: .init(
            hitEffects: [.id(.ef_criticalwound)]
        ),
        .npc_darkbreath: .init(
            effects: [.id(.ef_darkbreath)]
        ),
        .npc_darkstrike: .init(
            effects: [.id(.ef_soulstrike2)]
        ),
        .npc_darkthunder: .init(
            effects: [.id(.ef_yufitel)],
            hitEffects: [.id(.ef_yufitelhit)]
        ),
        .npc_defender: .init(
            effects: [.id(.ef_deffender)]
        ),
        .npc_dragonfear: .init(
            effects: [.id(.ef_dragonfear)]
        ),
        .npc_earthquake: .init(
            casterEffects: [.id(.ef_npc_earthquake)]
        ),
        .npc_fireattack: .init(
            hitEffects: [.id(.ef_firehit)]
        ),
        .npc_firebreath: .init(
            effects: [.name("ef_firebreath")],
            hitEffects: [.id(.ef_firehit)]
        ),
        .npc_groundattack: .init(
            hitEffects: [.id(.ef_earthhit)]
        ),
        .npc_guidedattack: .init(
            effects: [.id(.ef_guidedattack)]
        ),
        .npc_holyattack: .init(
            hitEffects: [.id(.ef_holyhit)]
        ),
        .npc_keeping: .init(
            effects: [.id(.ef_keeping)]
        ),
        .npc_magicalattack: .init(
            hitEffects: [.id(.ef_magicalatthit)]
        ),
        .npc_mentalbreaker: .init(
            effects: [.id(.ef_mentalbreak)]
        ),
        .npc_petrifyattack: .init(
            effects: [.id(.ef_petrifyattack)]
        ),
        .npc_piercingatt: .init(
            casterEffects: [.id(.ef_pierceself)]
        ),
        .npc_poison: .init(
            effects: [.id(.ef_poisonattack)]
        ),
        .npc_poisonattack: .init(
            hitEffects: [.id(.ef_poisonhit)]
        ),
        .npc_powerup: .init(
            effects: [.id(.ef_agiup)]
        ),
        .npc_provocation: .init(
            successEffects: [.id(.ef_provoke)]
        ),
        .npc_pulsestrike: .init(
            casterEffects: [.id(.ef_soulbreaker2)]
        ),
        .npc_selfdestruction: .init(
            effects: [.id(.ef_sui_explosion)]
        ),
        .npc_silenceattack: .init(
            effects: [.id(.ef_silenceattack)]
        ),
        .npc_sleepattack: .init(
            effects: [.id(.ef_sleepattack)]
        ),
        .npc_stop: .init(
            effects: [.id(.ef_npc_stop)]
        ),
        .npc_stunattack: .init(
            effects: [.id(.ef_stunattack)]
        ),
        .npc_suicide: .init(
            effects: [.id(.ef_suicide)]
        ),
        .npc_thunderbreath: .init(
            hitEffects: [.id(.ef_windhit)]
        ),
        .npc_venomfog: .init(
            effects: [.id(.ef_venomfog)]
        ),
        .npc_waterattack: .init(
            hitEffects: [.id(.ef_coldhit)]
        ),
        .npc_widebleeding: .init(
            casterEffects: [.id(.ef_bleeding)]
        ),
        .npc_widefreeze: .init(
            casterEffects: [.id(.ef_stormgust)]
        ),
        .npc_windattack: .init(
            hitEffects: [.id(.ef_windhit)]
        ),
        .nv_helpangel: .init(
            casterEffects: [.name("ef_nv_helpangel")]
        ),
        .nw_auto_firing_launcher: .init(
            effects: [.name("ef_nw_auto_firing_launcher")]
        ),
        .nw_basic_grenade: .init(
            effects: [.name("ef_nw_basic_grenade")]
        ),
        .nw_grenade_fragment: .init(
            effects: [.name("ef_nw_grenade_fragment")]
        ),
        .nw_grenades_dropping: .init(
            effects: [.name("ef_nw_grenades_dropping")]
        ),
        .nw_hidden_card: .init(
            effects: [.name("ef_nw_hidden_card")]
        ),
        .nw_intensive_aim: .init(
            effects: [.name("ef_nw_intensive_aim")]
        ),
        .nw_magazine_for_one: .init(
            effects: [.name("ef_nw_magazine_for_one")]
        ),
        .nw_mission_bombard: .init(
            hitEffects: [.name("ef_nw_mission_bombard_hit")]
        ),
        .nw_only_one_bullet: .init(
            effects: [.name("ef_nw_only_one_bullet")],
            hitEffects: [.name("ef_nw_only_one_bullet_hit")]
        ),
        .nw_spiral_shooting: .init(
            effects: [.name("ef_nw_spiral_shooting")]
        ),
        .nw_the_vigilante_at_night: .init(
            effects: [.name("ef_nw_the_vigilante_at_night")]
        ),
        .nw_wild_fire: .init(
            effects: [.name("ef_nw_wild_fire")]
        ),
        .pf_soulburn: .init(
            effects: [.id(.ef_soulburn)]
        ),
        .pf_soulchange: .init(
            effects: [.id(.ef_linelink2)]
        ),
        .rg_backstap: .init(
            hitEffects: [.id(.ef_backstap)]
        ),
        .rg_closeconfine: .init(
            effects: [.id(.ef_npc_stop2)]
        ),
        .rg_intimidate: .init(
            effects: [.id(.ef_intimidate)]
        ),
        .rg_raid: .init(
            casterEffects: [.id(.ef_teihit3)]
        ),
        .rg_stealcoin: .init(
            successEffects: [.id(.ef_stealcoin), .id(.ef_rg_coin)]
        ),
        .rg_striparmor: .init(
            successEffects: [.id(.ef_striparmor)]
        ),
        .rg_striphelm: .init(
            successEffects: [.id(.ef_striphelm)]
        ),
        .rg_stripshield: .init(
            successEffects: [.id(.ef_stripshield)]
        ),
        .rg_stripweapon: .init(
            successEffects: [.id(.ef_stripweapon)]
        ),
        .rl_c_marker: .init(
            successEffects: [.name("ef_c_marker1")]
        ),
        .rl_d_tail: .init(
            effects: [.name("ef_rl_d_tail")]
        ),
        .rl_e_chain: .init(
            effects: [.name("ef_rl_e_chain")]
        ),
        .rl_fallen_angel: .init(
            effects: [.name("ef_rl_fallen_angel")]
        ),
        .rl_fire_rain: .init(
            effects: [.name("ef_rl_fire_rain")]
        ),
        .rl_firedance: .init(
            effects: [.name("ef_rl_firedance")]
        ),
        .rl_h_mine: .init(
            effects: [.name("ef_rl_h_mine")]
        ),
        .rl_heat_barrel: .init(
            effects: [.name("ef_rl_heat_barrel")]
        ),
        .rl_p_alter: .init(
            effects: [.name("ef_rl_p_alter")]
        ),
        .rl_s_storm: .init(
            effects: [.name("ef_s_storm")]
        ),
        .rl_slugshot: .init(
            effects: [.name("ef_rl_slugshot")]
        ),
        .sa_dispell: .init(
            successEffects: [.id(.ef_dispell)]
        ),
    ]

    private static let skills3: [SkillID : SkillEffectDefinition] = [
        .sa_elementfire: .init(
            effects: [.id(.ef_flamelauncher)]
        ),
        .sa_elementground: .init(
            effects: [.id(.ef_seismicweapon)]
        ),
        .sa_elementwater: .init(
            effects: [.id(.ef_frostweapon)]
        ),
        .sa_elementwind: .init(
            effects: [.id(.ef_lightningloader)]
        ),
        .sa_flamelauncher: .init(
            successEffects: [.id(.ef_flamelauncher)]
        ),
        .sa_frostweapon: .init(
            successEffects: [.id(.ef_frostweapon)]
        ),
        .sa_instantdeath: .init(
            effects: [.name("ef_sa_instantdeath")]
        ),
        .sa_lightningloader: .init(
            successEffects: [.id(.ef_lightningloader)]
        ),
        .sa_magicrod: .init(
            successEffects: [.id(.ef_magicrod)]
        ),
        .sa_seismicweapon: .init(
            successEffects: [.id(.ef_seismicweapon)]
        ),
        .sa_spellbreaker: .init(
            successEffects: [.id(.ef_spellbreaker)]
        ),
        .sc_autoshadowspell: .init(
            effects: [.name("ef_sc_autoshadowspell")]
        ),
        .sc_bloodylust: .init(
            effects: [.id(.ef_bottom_bloodylust)]
        ),
        .sc_bodypaint: .init(
            effects: [.id(.ef_stretch)]
        ),
        .sc_chaospanic: .init(
            effects: [.id(.ef_bottom_ani)]
        ),
        .sc_dimensiondoor: .init(
            effects: [.id(.ef_forestlight6)]
        ),
        .sc_enervation: .init(
            effects: [.id(.ef_enervation)]
        ),
        .sc_fatalmenace: .init(
            effects: [.name("ef_sc_fatalmenace")],
            casterEffects: [.name("ef_sc_fatalmenace_cast")]
        ),
        .sc_groomy: .init(
            effects: [.id(.ef_enervation2)]
        ),
        .sc_ignorance: .init(
            effects: [.id(.ef_enervation3)]
        ),
        .sc_laziness: .init(
            effects: [.id(.ef_enervation4)]
        ),
        .sc_maelstrom: .init(
            effects: [.id(.ef_bottom_maelstrom)]
        ),
        .sc_manhole: .init(
            effects: [.id(.ef_bottom_manhole)],
            successEffects: [.id(.ef_manhole)]
        ),
        .sc_reproduce: .init(
            effects: [.name("ef_sc_reproduce")]
        ),
        .sc_triangleshot: .init(
            beforeHitEffects: [.name("ef_arrow_projectile")]
        ),
        .sc_unlucky: .init(
            effects: [.id(.ef_enervation5)]
        ),
        .sc_weakness: .init(
            effects: [.id(.ef_enervation6)]
        ),
        .sg_moon_comfort: .init(
            effects: [.id(.ef_bluecasting)]
        ),
        .sg_star_comfort: .init(
            effects: [.id(.ef_bluecasting)]
        ),
        .sg_sun_comfort: .init(
            effects: [.id(.ef_bluecasting)]
        ),
        .sh_blessing_of_mystical_creatures: .init(
            effects: [.name("ef_sh_blessing_of_mystical_creatures")]
        ),
        .sh_chul_ho_sonic_claw: .init(
            effects: [.name("ef_sh_chul_ho_sonic_claw")]
        ),
        .sh_colors_of_hyun_rok: .init(
            effects: [.name("ef_sh_colors_of_hyun_rok")]
        ),
        .sh_hogogong_strike: .init(
            effects: [.name("ef_sh_hogogong_strike")]
        ),
        .sh_howling_of_chul_ho: .init(
            effects: [.name("ef_sh_howling_of_chul_ho")]
        ),
        .sh_hyun_rok_cannon: .init(
            effects: [.name("ef_sh_hyun_rok_cannon")]
        ),
        .sh_ki_sul_rampage: .init(
            effects: [.name("ef_sh_ki_sul_rampage")]
        ),
        .sh_ki_sul_water_spraying: .init(
            effects: [.name("ef_sh_ki_sul_water_spraying")]
        ),
        .sh_marine_festival_of_ki_sul: .init(
            effects: [.name("ef_sh_marine_festival_of_ki_sul")]
        ),
        .sh_sandy_festival_of_ki_sul: .init(
            effects: [.name("ef_sh_sandy_festival_of_ki_sul")]
        ),
        .sh_temporary_communion: .init(
            effects: [.name("ef_sh_temporary_communion")]
        ),
        .sj_document: .init(
            effects: [.name("ef_sj_document")]
        ),
        .sj_fallingstar: .init(
            effects: [.name("ef_sj_fallingstar")]
        ),
        .sj_flashkick: .init(
            effects: [.name("ef_sj_flashkick")]
        ),
        .sj_fullmoonkick: .init(
            effects: [.name("ef_sj_fullmoonkick")]
        ),
        .sj_newmoonkick: .init(
            effects: [.name("ef_sj_newmoonkick")]
        ),
        .sj_prominencekick: .init(
            effects: [.name("ef_sj_prominencekick")]
        ),
        .sj_solarburst: .init(
            effects: [.name("ef_sj_solarburst")]
        ),
        .ske_all_in_the_sky: .init(
            effects: [.name("ef_ske_all_in_the_sky")]
        ),
        .ske_dawn_break: .init(
            effects: [.name("ef_ske_dawn_break")]
        ),
        .ske_enchanting_sky: .init(
            effects: [.name("ef_ske_enchanting_sky")]
        ),
        .ske_midnight_kick: .init(
            effects: [.name("ef_ske_midnight_kick")]
        ),
        .ske_noon_blast: .init(
            effects: [.name("ef_ske_noon_blast")]
        ),
        .ske_rising_sun: .init(
            effects: [.name("ef_ske_rising_sun")]
        ),
        .ske_star_burst: .init(
            effects: [.name("ef_ske_star_burst")]
        ),
        .ske_star_cannon: .init(
            effects: [.name("ef_ske_star_cannon")]
        ),
        .ske_sunset_blast: .init(
            effects: [.name("ef_ske_sunset_blast")]
        ),
        .ske_twinkling_galaxy: .init(
            effects: [.name("ef_ske_twinkling_galaxy")]
        ),
        .sl_assasin: .init(
            effects: [.name("ef_sl_assasin")]
        ),
        .sl_hunter: .init(
            effects: [.name("ef_sl_hunter")]
        ),
        .sl_kaahi: .init(
            effects: [.id(.ef_hated)]
        ),
        .sl_kaizel: .init(
            effects: [.id(.ef_kaizel)]
        ),
        .sl_ska: .init(
            effects: [.id(.ef_steelbody), .id(.ef_gumgang2)]
        ),
        .sl_stin: .init(
            effects: [.id(.ef_stin)]
        ),
        .sl_stun: .init(
            effects: [.id(.ef_stin3), .name("ef_sl_stun")]
        ),
        .sl_swoo: .init(
            effects: [.id(.ef_m07)]
        ),
        .so_diamonddust: .init(
            effects: [.id(.ef_coldthrow2), .name("ef_so_diamonddust")],
            casterEffects: [.name("ef_so_diamonddust_cast")]
        ),
        .so_earthgrave: .init(
            effects: [.name("ef_so_earthgrave")],
            hitEffects: [.name("ef_so_earthgrave_hit")]
        ),
        .so_el_cure: .init(
            effects: [.name("ef_so_el_cure")]
        ),
        .so_electricwalk: .init(
            effects: [.id(.ef_shockwave2)]
        ),
        .so_elemental_shield: .init(
            effects: [.id(.ef_so_elemental_shield)]
        ),
        .so_firewalk: .init(
            effects: [.id(.ef_firewall2)]
        ),
        .so_poison_buster: .init(
            effects: [.name("ef_so_poison_buster")]
        ),
        .so_psychic_wave: .init(
            effects: [.id(.ef_spr_plant10), .name("ef_so_psychic_wave")],
            casterEffects: [.name("ef_so_psychic_wave_cast")]
        ),
        .so_varetyr_spear: .init(
            beforeHitEffects: [.id(.ef_pressure3)]
        ),
        .so_warmer: .init(
            effects: [.id(.ef_demonicfire4)]
        ),
        .soa_circle_of_directions_and_elementals: .init(
            effects: [.name("ef_soa_circle_of_directions_and_elementals")]
        ),
        .soa_exorcism_of_malicious_soul: .init(
            effects: [.name("ef_soa_exorcism_of_malicious_soul")]
        ),
        .soa_soul_gathering: .init(
            effects: [.name("ef_soa_soul_gathering")]
        ),
        .soa_soul_of_heaven_and_earth: .init(
            effects: [.name("ef_soa_soul_of_heaven_and_earth")]
        ),
    ]

    private static let skills4: [SkillID : SkillEffectDefinition] = [
        .soa_talisman_of_black_tortoise: .init(
            effects: [.name("ef_soa_talisman_of_black_tortoise")]
        ),
        .soa_talisman_of_blue_dragon: .init(
            effects: [.name("ef_soa_talisman_of_blue_dragon")]
        ),
        .soa_talisman_of_five_elements: .init(
            effects: [.name("ef_soa_talisman_of_five_elements")]
        ),
        .soa_talisman_of_four_bearing_god: .init(
            effects: [.name("ef_soa_talisman_of_four_bearing_god")]
        ),
        .soa_talisman_of_magician: .init(
            effects: [.name("ef_soa_talisman_of_magician")]
        ),
        .soa_talisman_of_protection: .init(
            effects: [.name("ef_soa_talisman_of_protection")]
        ),
        .soa_talisman_of_red_phoenix: .init(
            effects: [.name("ef_soa_talisman_of_red_phoenix")]
        ),
        .soa_talisman_of_soul_stealing: .init(
            effects: [.name("ef_soa_talisman_of_soul_stealing")]
        ),
        .soa_talisman_of_warrior: .init(
            effects: [.name("ef_soa_talisman_of_warrior")]
        ),
        .soa_talisman_of_white_tiger: .init(
            effects: [.name("ef_soa_talisman_of_white_tiger")]
        ),
        .sp_soulcurse: .init(
            effects: [.name("ef_sp_soulcurse")]
        ),
        .sp_soulgolem: .init(
            effects: [.name("ef_sp_soulgolem")]
        ),
        .sp_soulrevolve: .init(
            effects: [.name("ef_sp_soulrevolve")]
        ),
        .ss_akumukesu: .init(
            effects: [.name("ef_ss_akumukesu")]
        ),
        .ss_ankokuryuuakumu: .init(
            effects: [.name("ef_ss_ankokuryuuakumu")]
        ),
        .ss_antenpou: .init(
            effects: [.name("ef_ss_antenpou")]
        ),
        .ss_fuumakouchiku: .init(
            effects: [.name("ef_ss_fuumakouchiku")]
        ),
        .ss_fuumashouaku: .init(
            effects: [.name("ef_ss_fuumashouaku")]
        ),
        .ss_hitouakumu: .init(
            effects: [.name("ef_ss_hitouakumu")]
        ),
        .ss_kageakumu: .init(
            effects: [.name("ef_ss_kageakumu")]
        ),
        .ss_kagegari: .init(
            effects: [.name("ef_ss_kagegari")]
        ),
        .ss_kagegissen: .init(
            effects: [.name("ef_ss_kagegissen")],
            hitEffects: [.name("ef_ss_kagegissen_hit")]
        ),
        .ss_kagenomai: .init(
            effects: [.name("ef_ss_kagenomai")]
        ),
        .ss_kinryuuhou: .init(
            effects: [.name("ef_ss_kinryuuhou")],
            hitEffects: [.name("ef_ss_kinryuuhou_hit")]
        ),
        .ss_kunaikaiten: .init(
            effects: [.name("ef_ss_kunaikaiten")]
        ),
        .ss_kunaikussetsu: .init(
            effects: [.name("ef_ss_kunaikussetsu")]
        ),
        .ss_kunaiwaikyoku: .init(
            effects: [.name("ef_ss_kunaiwaikyoku")]
        ),
        .ss_raidenpou: .init(
            beginCastEffects: [.name("ef_ss_raidenpou_cast")],
            effects: [.name("ef_ss_raidenpou")],
            hitEffects: [.name("ef_ss_raidenpou_hit")]
        ),
        .ss_reiketsuhou: .init(
            effects: [.name("ef_ss_reiketsuhou")]
        ),
        .ss_sekienhou: .init(
            effects: [.name("ef_ss_sekienhou")]
        ),
        .ss_shimiru: .init(
            effects: [.name("ef_ss_shimiru")]
        ),
        .ss_tokedasu: .init(
            effects: [.name("ef_ss_tokedasu")]
        ),
        .st_preserve: .init(
            effects: [.id(.ef_guard2)]
        ),
        .st_rejectsword: .init(
            effects: [.id(.ef_rejectsword)]
        ),
        .su_arclousedash: .init(
            effects: [.name("ef_su_arclousedash")]
        ),
        .su_bite: .init(
            effects: [.name("ef_su_bite")]
        ),
        .su_bunchofshrimp: .init(
            effects: [.name("ef_su_bunchofshrimp")]
        ),
        .su_chattering: .init(
            effects: [.name("ef_su_chattering")]
        ),
        .su_freshshrimp: .init(
            effects: [.name("ef_su_freshshrimp")]
        ),
        .su_grooming: .init(
            effects: [.name("ef_su_grooming")]
        ),
        .su_hiss: .init(
            effects: [.name("ef_su_hiss")]
        ),
        .su_nyanggrass: .init(
            effects: [.name("ef_su_nyanggrass")]
        ),
        .su_pickypeck: .init(
            effects: [.name("ef_su_pickypeck")]
        ),
        .su_powerofflock: .init(
            effects: [.name("ef_su_powerofflock")]
        ),
        .su_scaroftarou: .init(
            effects: [.name("ef_su_scaroftarou")]
        ),
        .su_scratch: .init(
            effects: [.name("ef_su_scratch")]
        ),
        .su_sv_stemspear: .init(
            effects: [.name("ef_su_sv_stemspear")]
        ),
        .su_svg_spirit: .init(
            effects: [.name("ef_su_svg_spirit")]
        ),
        .su_tunabelly: .init(
            effects: [.name("ef_su_tunabelly")]
        ),
        .tk_counter: .init(
            effects: [.name("ef_tk_counter")]
        ),
        .tk_highjump: .init(
            casterEffects: [.id(.ef_jumpbody)]
        ),
        .tk_jumpkick: .init(
            hitEffects: [.id(.ef_jumpkick)]
        ),
        .wl_chainlightning: .init(
            casterEffects: [.name("ef_wl_chainlightning_cast")]
        ),
        .wl_chainlightning_atk: .init(
            effects: [.id(.ef_chainl_str)]
        ),
        .wl_comet: .init(
            effects: [.name("ef_wl_comet")],
            casterEffects: [.name("ef_wl_comet_cast")]
        ),
        .wl_crimsonrock: .init(
            effects: [.id(.ef_crimson_str)]
        ),
        .wl_frostmisty: .init(
            effects: [.id(.ef_frostmysty)]
        ),
        .wl_hellinferno: .init(
            effects: [.name("ef_wl_hellinferno"), .id(.ef_hell_str)],
            casterEffects: [.name("ef_wl_hellinferno_cast")]
        ),
        .wl_jackfrost: .init(
            hitEffects: [.id(.ef_frostdiver2)],
            casterEffects: [.name("ef_jackfrost")]
        ),
        .wl_marshofabyss: .init(
            effects: [.id(.ef_spr_mash)]
        ),
        .wl_recognizedspell: .init(
            effects: [.id(.ef_recognized)]
        ),
        .wl_siennaexecrate: .init(
            effects: [.name("ef_siennaexecrate")]
        ),
        .wl_soulexpansion: .init(
            hitEffects: [.name("ef_wl_soulexpansion_hit")],
            casterEffects: [.name("ef_wl_soulexpansion_cast")]
        ),
        .wl_stasis: .init(
            effects: [.id(.ef_stasis)]
        ),
        .wl_summon_atk_fire: .init(
            effects: [.name("ef_wl_summon_atk_fire")]
        ),
        .wl_telekinesis_intense: .init(
            effects: [.id(.ef_wl_telekinesis_intense)]
        ),
        .wl_tetravortex: .init(
            effects: [.id(.ef_tetra)]
        ),
        .wl_tetravortex_fire: .init(
            effects: [.name("ef_wl_tetravortex_fire")]
        ),
        .wl_tetravortex_water: .init(
            effects: [.name("ef_wl_tetravortex_water")]
        ),
        .wl_tetravortex_wind: .init(
            effects: [.name("ef_wl_tetravortex_wind")]
        ),
        .wl_whiteimprison: .init(
            effects: [.id(.ef_bottom_basilica2)]
        ),
        .ws_cartboost: .init(
            effects: [.id(.ef_cartboost)]
        ),
        .ws_meltdown: .init(
            effects: [.id(.ef_meltdown)]
        ),
        .wz_earthspike: .init(
            effects: [.id(.ef_earthspike)],
            hitEffects: [.id(.ef_earthhit)]
        ),
        .wz_firepillar: .init(
            effects: [.id(.ef_firepillar), .id(.ef_firepillaron)],
            hitEffects: [.id(.ef_firepillarbomb)]
        ),
        .wz_frostnova: .init(
            hitEffects: [.id(.ef_coldhit)],
            casterEffects: [.id(.ef_frostdiver2)]
        ),
        .wz_heavendrive: .init(
            effects: [.id(.ef_heavensdrive)],
            hitEffects: [.id(.ef_earthhit)]
        ),
        .wz_icewall: .init(
            effects: [.id(.ef_icewall)]
        ),
        .wz_jupitel: .init(
            effects: [.id(.ef_yufitel)],
            beforeHitEffects: [.id(.ef_yufitelhit)]
        ),
        .wz_meteor: .init(
            effects: [.id(.ef_meteorstorm)],
            hitEffects: [.id(.ef_firehit)]
        ),
    ]

    private static let skills5: [SkillID : SkillEffectDefinition] = [
        .wz_quagmire: .init(
            effects: [.id(.ef_quagmire)]
        ),
        .wz_sightrasher: .init(
            effects: [.id(.ef_sightrasher)],
            hitEffects: [.id(.ef_firehit)]
        ),
        .wz_stormgust: .init(
            effects: [.id(.ef_stormgust)],
            hitEffects: [.id(.ef_coldhit)]
        ),
        .wz_vermilion: .init(
            effects: [.id(.ef_lord)],
            hitEffects: [.id(.ef_windhit)]
        ),
    ]
}
