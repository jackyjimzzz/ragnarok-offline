//
//  SkillEffectTable+RagOff.swift
//  RagnarokEffects
//
//  [RagOff iPad Mod] Extra skill effects for Swordman, Archer, Acolyte and Thief classes.
//  Converted automatically from roBrowserLegacy SkillEffect.js
//  (https://github.com/MrAntares/roBrowserLegacy/blob/master/src/DB/Skills/SkillEffect.js).
//

import RagnarokConstants

enum RagOffSkillEffectTable {
    static let table: [SkillID : SkillEffectDefinition] = {
        var table: [SkillID : SkillEffectDefinition] = [:]
        for chunk in [skills0, skills1, skills2, skills3, skills4] {
            table.merge(chunk) { first, _ in first }
        }
        return table
    }()

    private static let skills0: [SkillID : SkillEffectDefinition] = [
        .ab_adoramus: .init(
            effects: [.id(.ef_ado_str)]
        ),
        .ab_ancilla: .init(
            effects: [.name("ef_ancilla")]
        ),
        .ab_cheal: .init(
            effects: [.id(.ef_heal2)]
        ),
        .ab_duplelight: .init(
            effects: [.name("ef_duplelight")]
        ),
        .ab_epiclesis: .init(
            effects: [.id(.ef_glasswall4), .id(.ef_glasswall3)]
        ),
        .ab_highnessheal: .init(
            effects: [.id(.ef_heal4)],
            hitEffects: [.id(.ef_heal3)]
        ),
        .ab_judex: .init(
            effects: [.id(.ef_firepillaron2)],
            hitEffects: [.id(.ef_holyhit)]
        ),
        .ab_offertorium: .init(
            effects: [.id(.ef_ab_offertorium)]
        ),
        .ab_secrament: .init(
            effects: [.name("ef_ab_secrament")]
        ),
        .ac_chargearrow: .init(
            hitEffects: [.id(.ef_hit1)]
        ),
        .al_holylight: .init(
            effects: [.id(.ef_holyhit)]
        ),
        .al_pneuma: .init(
            effects: [.id(.ef_pneuma)]
        ),
        .al_ruwach: .init(
            hitEffects: [.id(.ef_hit2)]
        ),
        .as_enchantpoison: .init(
            effects: [.id(.ef_pattack)]
        ),
        .as_grimtooth: .init(
            effects: [.id(.ef_grimtooth)]
        ),
        .as_venomknife: .init(
            beforeHitEffects: [.id(.ef_throwitem6)]
        ),
        .asc_breaker: .init(
            beforeHitEffects: [.id(.ef_soulbreaker)]
        ),
        .asc_meteorassault: .init(
            casterEffects: [.id(.ef_soulbreaker2)]
        ),
        .ba_appleidun: .init(
            effects: [.id(.ef_bottom_appleidun)]
        ),
        .ba_assassincross: .init(
            effects: [.id(.ef_bottom_assassincross)]
        ),
        .ba_musicalstrike: .init(
            beforeHitEffects: [.name("ef_arrow_projectile")]
        ),
        .ba_pangvoice: .init(
            successEffects: [.id(.ef_fvoice)]
        ),
        .ba_poembragi: .init(
            effects: [.id(.ef_bottom_poembragi)]
        ),
        .ba_whistle: .init(
            effects: [.id(.ef_bottom_whistle)]
        ),
        .bd_drumbattlefield: .init(
            effects: [.id(.ef_bottom_drumbattlefield)]
        ),
        .bd_eternalchaos: .init(
            effects: [.id(.ef_bottom_eternalchaos)]
        ),
        .bd_intoabyss: .init(
            effects: [.id(.ef_bottom_intoabyss)]
        ),
        .bd_lullaby: .init(
            effects: [.id(.ef_bottom_lullaby)]
        ),
        .bd_richmankim: .init(
            effects: [.id(.ef_bottom_richmankim)]
        ),
        .bd_ringnibelungen: .init(
            effects: [.id(.ef_bottom_ringnibelungen)]
        ),
        .bd_rokisweil: .init(
            effects: [.id(.ef_bottom_rokisweil)]
        ),
        .bd_siegfried: .init(
            effects: [.id(.ef_bottom_siegfried)]
        ),
        .cd_arbitrium: .init(
            effects: [.name("ef_cd_arbitrium")],
            hitEffects: [.name("ef_cd_arbitrium_hit")],
            casterEffects: [.name("ef_cd_arbitrium_cast")]
        ),
        .cd_arbitrium_atk: .init(
            effects: [.name("ef_cd_arbitrium_atk")]
        ),
        .cd_argutus_telum: .init(
            effects: [.name("ef_cd_argutus_telum")],
            casterEffects: [.name("ef_cd_argutus_telum_cast")]
        ),
        .cd_argutus_vita: .init(
            effects: [.name("ef_cd_argutus_vita")],
            casterEffects: [.name("ef_cd_argutus_vita_cast")]
        ),
        .cd_benedictum: .init(
            effects: [.name("ef_cd_benedictum")],
            casterEffects: [.name("ef_cd_benedictum_cast")]
        ),
        .cd_competentia: .init(
            effects: [.name("ef_cd_competentia")],
            casterEffects: [.name("ef_cd_competentia_cast")]
        ),
        .cd_dilectio_heal: .init(
            effects: [.name("ef_cd_dilectio_heal")],
            casterEffects: [.name("ef_cd_dilectio_heal_cast")]
        ),
        .cd_effligo: .init(
            effects: [.name("ef_cd_effligo")],
            hitEffects: [.name("ef_cd_effligo_hit")]
        ),
        .cd_framen: .init(
            effects: [.name("ef_cd_framen")]
        ),
        .cd_mediale_votum: .init(
            effects: [.name("ef_cd_mediale_votum")],
            casterEffects: [.name("ef_cd_mediale_votum_cast")]
        ),
        .cd_petitio: .init(
            effects: [.name("ef_cd_petitio")]
        ),
        .cd_pneumaticus_procella: .init(
            effects: [.name("ef_cd_pneumaticus_procella")],
            casterEffects: [.name("ef_cd_pneumaticus_procella_cast")]
        ),
        .cd_presens_acies: .init(
            effects: [.name("ef_cd_presens_acies")],
            casterEffects: [.name("ef_cd_presens_acies_cast")]
        ),
        .cd_religio: .init(
            effects: [.name("ef_cd_religio")],
            casterEffects: [.name("ef_cd_religio_cast")]
        ),
        .cd_reparatio: .init(
            effects: [.name("ef_cd_reparatio")],
            casterEffects: [.name("ef_cd_reparatio_cast")]
        ),
        .cg_arrowvulcan: .init(
            effects: [.id(.ef_tripleattack3)],
            beforeHitEffects: [.name("ef_arrow_projectile")]
        ),
        .cg_hermode: .init(
            effects: [.name("517_music")]
        ),
        .ch_palmstrike: .init(
            hitEffects: [.id(.ef_hitline2)]
        ),
        .ch_soulcollect: .init(
            beginCastEffects: [.id(.ef_beginspell)]
        ),
        .ch_tigerfist: .init(
            effects: [.id(.ef_bash3d2)],
            casterEffects: [.id(.ef_gumgang3)]
        ),
        .cr_autoguard: .init(
            effects: [.id(.ef_guard)]
        ),
        .cr_defender: .init(
            effects: [.id(.ef_defender)]
        ),
        .cr_devotion: .init(
            effects: [.id(.ef_devotion)]
        ),
        .cr_fullprotection: .init(
            effects: [.id(.ef_chemicalprotection)]
        ),
        .cr_grandcross: .init(
            effects: [.id(.ef_grandcross)]
        ),
        .cr_holycross: .init(
            effects: [.id(.ef_holycross)]
        ),
        .cr_providence: .init(
            effects: [.id(.ef_providence)]
        ),
        .cr_reflectshield: .init(
            effects: [.id(.ef_reflectshield)]
        ),
    ]

    private static let skills1: [SkillID : SkillEffectDefinition] = [
        .cr_shieldboomerang: .init(
            effects: [.id(.ef_shieldboomerang)],
            beforeHitEffects: [.name("ef_shield_projectile")]
        ),
        .cr_shieldcharge: .init(
            effects: [.id(.ef_shieldcharge)]
        ),
        .cr_spearquicken: .init(
            effects: [.id(.ef_spearquicken)]
        ),
        .dc_dontforgetme: .init(
            effects: [.id(.ef_bottom_dontforgetme)]
        ),
        .dc_fortunekiss: .init(
            effects: [.id(.ef_bottom_fortunekiss)]
        ),
        .dc_humming: .init(
            effects: [.id(.ef_bottom_humming)]
        ),
        .dc_serviceforyou: .init(
            effects: [.id(.ef_bottom_serviceforyou)]
        ),
        .dc_throwarrow: .init(
            beforeHitEffects: [.name("ef_arrow_projectile")]
        ),
        .dc_winkcharm: .init(
            successEffects: [.id(.ef_wink)]
        ),
        .dk_chargingpierce: .init(
            hitEffects: [.name("ef_dk_chargingpierce_hit")],
            casterEffects: [.name("ef_dk_chargingpierce_cast")]
        ),
        .dk_dragonic_aura: .init(
            casterEffects: [.name("ef_dk_dragonic_aura")]
        ),
        .dk_dragonic_breath: .init(
            effects: [.name("ef_dk_dragonic_breath")],
            hitEffects: [.name("ef_dk_dragonic_breath_hit")]
        ),
        .dk_hackandslasher: .init(
            effects: [.name("ef_dk_hackandslasher")],
            hitEffects: [.name("ef_dk_hackandslasher_hit")]
        ),
        .dk_hackandslasher_atk: .init(
            effects: [.name("ef_dk_hackandslasher_atk")]
        ),
        .dk_madness_crusher: .init(
            effects: [.name("ef_dk_madness_crusher")]
        ),
        .dk_servant_w_demol: .init(
            hitEffects: [.name("ef_dk_servant_w_demol_hit")]
        ),
        .dk_servant_w_phantom: .init(
            effects: [.name("ef_dk_servant_w_phantom")]
        ),
        .dk_servant_w_sign: .init(
            effects: [.name("ef_dk_servant_w_sign")]
        ),
        .dk_servantweapon: .init(
            effects: [.name("ef_dk_servantweapon")],
            hitEffects: [.name("ef_dk_servantweapon_hit")],
            casterEffects: [.name("ef_dk_servantweapon_cast")]
        ),
        .dk_servantweapon_atk: .init(
            effects: [.name("ef_dk_servantweapon_atk")]
        ),
        .dk_stormslash: .init(
            hitEffects: [.name("ef_dk_stormslash_hit")]
        ),
        .dk_vigor: .init(
            effects: [.name("ef_dk_vigor")],
            casterEffects: [.name("ef_dk_vigor_cast")]
        ),
        .hp_assumptio: .init(
            effects: [.id(.ef_assumptio2)]
        ),
        .ht_blastmine: .init(
            hitEffects: [.id(.ef_blastminebomb)]
        ),
        .ht_blitzbeat: .init(
            effects: [.id(.ef_blitzbeat)]
        ),
        .ht_claymoretrap: .init(
            hitEffects: [.id(.ef_claymore)]
        ),
        .ht_detecting: .init(
            effects: [.id(.ef_detecting)]
        ),
        .ht_flasher: .init(
            hitEffects: [.id(.ef_flasher)]
        ),
        .ht_freezingtrap: .init(
            hitEffects: [.id(.ef_freezing)]
        ),
        .ht_landmine: .init(
            effects: [.name("ef_ht_landmine")]
        ),
        .ht_phantasmic: .init(
            beforeHitEffects: [.name("ef_arrow_projectile")],
            hitEffects: [.id(.ef_hit2)]
        ),
        .ht_removetrap: .init(
            effects: [.id(.ef_removetrap)]
        ),
        .ht_sandman: .init(
            hitEffects: [.id(.ef_sandman)]
        ),
        .ht_shockwave: .init(
            effects: [.id(.ef_shockwave)],
            hitEffects: [.id(.ef_shockwavehit)]
        ),
        .ht_skidtrap: .init(
            effects: [.id(.ef_skidtrap)]
        ),
        .ht_springtrap: .init(
            effects: [.id(.ef_springtrap)]
        ),
        .ig_attack_stance: .init(
            effects: [.name("ef_ig_attack_stance")],
            casterEffects: [.name("ef_ig_attack_stance_cast")]
        ),
        .ig_cross_rain: .init(
            casterEffects: [.name("ef_ig_cross_rain_cast")]
        ),
        .ig_grand_judgement: .init(
            effects: [.name("ef_ig_grand_judgement")],
            casterEffects: [.name("ef_ig_grand_judgement_cast")]
        ),
        .ig_guard_stance: .init(
            effects: [.name("ef_ig_guard_stance")],
            casterEffects: [.name("ef_ig_guard_stance_cast")]
        ),
        .ig_guardian_shield: .init(
            effects: [.name("ef_ig_guardian_shield")]
        ),
        .ig_holy_shield: .init(
            effects: [.name("ef_ig_holy_shield")],
            casterEffects: [.name("ef_ig_holy_shield_cast")]
        ),
        .ig_judgement_cross: .init(
            effects: [.name("ef_ig_judgement_cross")],
            hitEffects: [.name("ef_ig_judgement_cross_hit")],
            casterEffects: [.name("ef_ig_judgement_cross_cast")]
        ),
        .ig_overslash: .init(
            effects: [.name("ef_ig_overslash")],
            hitEffects: [.name("ef_ig_overslash_hit")],
            casterEffects: [.name("ef_ig_overslash_cast")]
        ),
        .ig_rebound_shield: .init(
            effects: [.name("ef_ig_rebound_shield")],
            casterEffects: [.name("ef_ig_rebound_shield_cast")]
        ),
        .ig_shield_shooting: .init(
            effects: [.name("ef_ig_shield_shooting")],
            hitEffects: [.name("ef_ig_shield_shooting_hit")],
            casterEffects: [.name("ef_ig_shield_shooting_cast")]
        ),
        .ig_ultimate_sacrifice: .init(
            effects: [.name("ef_ig_ultimate_sacrifice")]
        ),
        .iq_exposion_blaster: .init(
            effects: [.name("ef_iq_exposion_blaster")],
            hitEffects: [.name("ef_iq_exposion_blaster_hit")]
        ),
        .iq_firm_faith: .init(
            effects: [.name("ef_iq_firm_faith")]
        ),
        .iq_first_brand: .init(
            effects: [.name("ef_iq_first_brand")],
            hitEffects: [.name("ef_iq_first_brand_hit")]
        ),
        .iq_first_faith_power: .init(
            effects: [.name("ef_iq_first_faith_power")],
            casterEffects: [.name("ef_iq_first_faith_power_cast")]
        ),
        .iq_judge: .init(
            effects: [.name("ef_iq_judge")],
            casterEffects: [.name("ef_iq_judge_cast")]
        ),
        .iq_massive_f_blaster: .init(
            effects: [.name("ef_iq_massive_f_blaster")],
            hitEffects: [.name("ef_iq_massive_f_blaster_hit")]
        ),
        .iq_oleum_sanctum: .init(
            effects: [.name("ef_iq_oleum_sanctum")],
            hitEffects: [.name("ef_iq_oleum_sanctum_hit")]
        ),
        .iq_powerful_faith: .init(
            effects: [.name("ef_iq_powerful_faith")]
        ),
        .iq_second_faith: .init(
            effects: [.name("ef_iq_second_faith")]
        ),
        .iq_second_flame: .init(
            effects: [.name("ef_iq_second_flame")]
        ),
        .iq_second_judgement: .init(
            effects: [.name("ef_iq_second_judgement")]
        ),
        .iq_sincere_faith: .init(
            effects: [.name("ef_iq_sincere_faith")]
        ),
        .iq_third_consecration: .init(
            effects: [.name("ef_iq_third_consecration")]
        ),
    ]

    private static let skills2: [SkillID : SkillEffectDefinition] = [
        .iq_third_exor_flame: .init(
            effects: [.name("ef_iq_third_exor_flame")],
            casterEffects: [.name("ef_iq_third_exor_flame_cast")]
        ),
        .iq_third_flame_bomb: .init(
            effects: [.name("ef_iq_third_flame_bomb")]
        ),
        .iq_third_punish: .init(
            effects: [.name("ef_iq_third_punish")]
        ),
        .kn_bowlingbash: .init(
            hitEffects: [.id(.ef_hit2)],
            casterEffects: [.id(.ef_bowlingself)]
        ),
        .kn_brandishspear: .init(
            effects: [.id(.ef_brandishspear)],
            casterEffects: [.id(.ef_brandish2)]
        ),
        .kn_chargeatk: .init(
            hitEffects: [.name("enemy_hit_normal1")]
        ),
        .kn_pierce: .init(
            hitEffects: [.id(.ef_earthhit)],
            casterEffects: [.id(.ef_pierceself)]
        ),
        .kn_spearboomerang: .init(
            beforeHitEffects: [.name("ef_spear_projectile")],
            hitEffects: [.id(.ef_spearbmr)],
            casterEffects: [.id(.ef_spearbmrself)]
        ),
        .kn_spearstab: .init(
            casterEffects: [.id(.ef_spearstabself)]
        ),
        .kn_twohandquicken: .init(
            effects: [.id(.ef_twohandquicken)]
        ),
        .lg_banding: .init(
            effects: [.id(.ef_primecharge3)]
        ),
        .lg_banishingpoint: .init(
            effects: [.name("ef_banishingpoint")],
            casterEffects: [.name("ef_lg_banishingpoint_cast")]
        ),
        .lg_cannonspear: .init(
            effects: [.name("ef_cannonspear"), .name("ef_lg_cannonspear")]
        ),
        .lg_earthdrive: .init(
            effects: [.name("ef_earthdrive"), .name("ef_lg_earthdrive")]
        ),
        .lg_exeedbreak: .init(
            effects: [.name("ef_exceedbreak")]
        ),
        .lg_hesperuslit: .init(
            effects: [.name("ef_hesperuslit")]
        ),
        .lg_inspiration: .init(
            effects: [.id(.ef_primecharge4)]
        ),
        .lg_kings_grace: .init(
            effects: [.name("ef_kings_grace")]
        ),
        .lg_moonslasher: .init(
            effects: [.name("ef_moonslasher")]
        ),
        .lg_overbrand: .init(
            effects: [.name("ef_overbrand")],
            hitEffects: [.name("ef_lg_overbrand_hit")],
            casterEffects: [.name("ef_lg_overbrand_cast")]
        ),
        .lg_piety: .init(
            effects: [.name("ef_piety")]
        ),
        .lg_pinpointattack: .init(
            effects: [.name("ef_pinpointattack")]
        ),
        .lg_prestige: .init(
            effects: [.id(.ef_primecharge2)]
        ),
        .lg_rageburst: .init(
            effects: [.name("ef_rageburst")]
        ),
        .lg_rayofgenesis: .init(
            effects: [.name("ef_rayofgenesis"), .name("ef_lg_rayofgenesis")],
            hitEffects: [.name("ef_lg_rayofgenesis_hit")],
            casterEffects: [.name("ef_lg_rayofgenesis_cast")]
        ),
        .lg_reflectdamage: .init(
            effects: [.name("ef_reflectdamage")]
        ),
        .lg_shieldpress: .init(
            beforeHitEffects: [.id(.ef_pressure2)]
        ),
        .lg_shieldspell: .init(
            effects: [.name("ef_shieldspell")]
        ),
        .lg_trample: .init(
            effects: [.name("ef_trample")]
        ),
        .lk_aurablade: .init(
            effects: [.id(.ef_aurablade)]
        ),
        .lk_berserk: .init(
            effects: [.id(.ef_redbody)]
        ),
        .lk_concentration: .init(
            effects: [.id(.ef_lkconcentration)]
        ),
        .lk_fury: .init(
            effects: [.id(.ef_redbody)]
        ),
        .lk_headcrush: .init(
            beginCastEffects: [.id(.ef_bash3d3)],
            hitEffects: [.name("enemy_hit_normal1")]
        ),
        .lk_jointbeat: .init(
            beginCastEffects: [.id(.ef_bash3d4)],
            hitEffects: [.name("enemy_hit_normal1")]
        ),
        .lk_parrying: .init(
            effects: [.id(.ef_guard)]
        ),
        .lk_spiralpierce: .init(
            effects: [.id(.ef_magnum2)],
            hitEffects: [.name("spear_hit_sound")]
        ),
        .mi_echosong: .init(
            effects: [.name("ef_echo_song")]
        ),
        .mi_harmonize: .init(
            effects: [.name("ef_harmonize")]
        ),
        .mi_rush_windmill: .init(
            effects: [.name("ef_rush_windmill")]
        ),
        .mo_absorbspirits: .init(
            casterEffects: [.id(.ef_absorbspirits)]
        ),
        .mo_chaincombo: .init(
            effects: [.id(.ef_teihit1), .id(.ef_chaincombo)],
            casterEffects: [.id(.ef_gumgang3)]
        ),
        .mo_explosionspirits: .init(
            beginCastEffects: [.id(.ef_beginspell)],
            casterEffects: [.id(.ef_gumgang2)]
        ),
        .mo_fingeroffensive: .init(
            effects: [.id(.ef_tanji)],
            hitEffects: [.id(.ef_hit2)]
        ),
        .mo_investigate: .init(
            effects: [.id(.ef_chimto)]
        ),
        .mo_steelbody: .init(
            effects: [.id(.ef_steelbody)]
        ),
        .mo_tripleattack: .init(
            effects: [.id(.ef_tripleattack)]
        ),
        .pa_gospel: .init(
            effects: [.id(.ef_bottom_gospel)]
        ),
        .pa_pressure: .init(
            beforeHitEffects: [.id(.ef_pressure)]
        ),
        .pa_sacrifice: .init(
            effects: [.id(.ef_bash3d)]
        ),
        .pa_shieldchain: .init(
            beforeHitEffects: [.name("ef_shield_projectile")]
        ),
        .pr_aspersio: .init(
            effects: [.id(.ef_aspersio)]
        ),
        .pr_benedictio: .init(
            effects: [.id(.ef_benedictio)]
        ),
        .pr_gloria: .init(
            effects: [.id(.ef_gloria)]
        ),
        .pr_impositio: .init(
            effects: [.id(.ef_impositio)]
        ),
        .pr_kyrie: .init(
            effects: [.id(.ef_kyrie)]
        ),
        .pr_lexaeterna: .init(
            effects: [.id(.ef_lexaeterna)]
        ),
        .pr_lexdivina: .init(
            effects: [.id(.ef_lexdivina)]
        ),
        .pr_magnificat: .init(
            effects: [.id(.ef_magnificat)]
        ),
        .pr_magnus: .init(
            effects: [.id(.ef_magnus), .id(.ef_bottom_mag)],
            hitEffects: [.id(.ef_holyhit)]
        ),
    ]

    private static let skills3: [SkillID : SkillEffectDefinition] = [
        .pr_sanctuary: .init(
            effects: [.id(.ef_sanctuary), .id(.ef_bottom_sanc)]
        ),
        .pr_slowpoison: .init(
            effects: [.id(.ef_slowpoison)]
        ),
        .pr_strecovery: .init(
            effects: [.id(.ef_recovery)]
        ),
        .pr_suffragium: .init(
            effects: [.id(.ef_suffragium)]
        ),
        .pr_turnundead: .init(
            hitEffects: [.id(.ef_holyhit)]
        ),
        .ra_aimedbolt: .init(
            effects: [.id(.ef_aimed_str)],
            beforeHitEffects: [.name("ef_arrow_projectile")]
        ),
        .ra_arrowstorm: .init(
            effects: [.id(.ef_arrowstorm_str)]
        ),
        .ra_detonator: .init(
            effects: [.id(.ef_concentration2)]
        ),
        .ra_fearbreeze: .init(
            effects: [.name("ef_ra_fearbreeze")]
        ),
        .ra_unlimit: .init(
            effects: [.name("ef_ra_unlimit")]
        ),
        .ra_wugbite: .init(
            effects: [.name("ef_wugbite")]
        ),
        .ra_wugrider: .init(
            effects: [.name("ef_wugrider")]
        ),
        .ra_wugstrike: .init(
            effects: [.name("ef_wugstrike")]
        ),
        .rk_dragonbreath: .init(
            hitEffects: [.id(.ef_m05)]
        ),
        .rk_dragonbreath_water: .init(
            hitEffects: [.name("ef_dragonbreath_water")]
        ),
        .rk_dragonhowling: .init(
            effects: [.id(.ef_dhowl_str)]
        ),
        .rk_enchantblade: .init(
            effects: [.id(.ef_potion_berserk2)]
        ),
        .rk_ignitionbreak: .init(
            casterEffects: [.id(.ef_ign_str)]
        ),
        .rk_luxanima: .init(
            effects: [.id(.ef_rk_luxanima)]
        ),
        .rk_millenniumshield: .init(
            effects: [.id(.ef_milshield_str)]
        ),
        .rk_sonicwave: .init(
            effects: [.id(.ef_heal_n)]
        ),
        .rk_windcutter: .init(
            effects: [.name("ef_rk_windcutter")]
        ),
        .sm_magnum: .init(
            hitEffects: [.id(.ef_firehit)]
        ),
        .sn_falconassault: .init(
            effects: [.id(.ef_falconassault)]
        ),
        .sn_sharpshooting: .init(
            beforeHitEffects: [.name("ef_arrow_projectile")],
            hitEffects: [.id(.ef_tripleattack2)]
        ),
        .sn_sight: .init(
            effects: [.id(.ef_truesight)]
        ),
        .sn_windwalk: .init(
            effects: [.id(.ef_portal4)]
        ),
        .sr_crescentelbow: .init(
            effects: [.name("ef_crescentelbow")]
        ),
        .sr_cursedcircle: .init(
            effects: [.name("ef_cursedcircle")]
        ),
        .sr_dragoncombo: .init(
            effects: [.name("ef_dragoncombo")]
        ),
        .sr_earthshaker: .init(
            effects: [.id(.ef_electric4)]
        ),
        .sr_fallenempire: .init(
            effects: [.name("ef_fallenempire"), .name("ef_sr_fallenempire")],
            hitEffects: [.name("ef_sr_fallenempire_hit")]
        ),
        .sr_flashcombo: .init(
            effects: [.id(.ef_sr_flashcombo)]
        ),
        .sr_gateofhell: .init(
            effects: [.name("ef_gateofhell")],
            casterEffects: [.name("ef_sr_gateofhell_cast")]
        ),
        .sr_howlingoflion: .init(
            effects: [.name("ef_howlingoflion"), .name("ef_sr_howlingoflion")],
            hitEffects: [.name("ef_sr_howlingoflion_hit")],
            casterEffects: [.name("ef_sr_howlingoflion_cast")]
        ),
        .sr_knucklearrow: .init(
            effects: [.name("ef_knucklearrow")]
        ),
        .sr_lightningwalk: .init(
            effects: [.name("ef_lightningwalk"), .name("ef_sr_lightningwalk")]
        ),
        .sr_powervelocity: .init(
            effects: [.name("ef_powervelocity")]
        ),
        .sr_raisingdragon: .init(
            effects: [.name("ef_raisingdragon")]
        ),
        .sr_rampageblaster: .init(
            effects: [.name("ef_rampageblaster"), .name("ef_sr_rampageblaster")]
        ),
        .sr_rideinlightning: .init(
            effects: [.name("ef_rideinlightning")]
        ),
        .sr_skynetblow: .init(
            effects: [.name("ef_skynetblow")]
        ),
        .sr_tigercannon: .init(
            effects: [.name("ef_tigercannon"), .name("ef_sr_tigercannon")]
        ),
        .sr_windmill: .init(
            effects: [.name("ef_windmill")]
        ),
        .tf_detoxify: .init(
            effects: [.id(.ef_detoxication)]
        ),
        .tf_poison: .init(
            hitEffects: [.id(.ef_pattack)]
        ),
        .tf_steal: .init(
            successEffects: [.id(.ef_steal)]
        ),
        .tf_throwstone: .init(
            beforeHitEffects: [.id(.ef_throwitem3)]
        ),
        .tr_ain_rhapsody: .init(
            effects: [.name("ef_tr_ain_rhapsody")],
            casterEffects: [.name("ef_tr_ain_rhapsody_cast")]
        ),
        .tr_gef_nocturn: .init(
            effects: [.name("ef_tr_gef_nocturn")],
            casterEffects: [.name("ef_tr_gef_nocturn_cast")]
        ),
        .tr_jawaii_serenade: .init(
            effects: [.name("ef_tr_jawaii_serenade")],
            casterEffects: [.name("ef_tr_jawaii_serenade_cast")]
        ),
        .tr_kvasir_sonata: .init(
            effects: [.name("ef_tr_kvasir_sonata")],
            casterEffects: [.name("ef_tr_kvasir_sonata_cast")]
        ),
        .tr_metalic_fury: .init(
            effects: [.name("ef_tr_metalic_fury")]
        ),
        .tr_musical_interlude: .init(
            effects: [.name("ef_tr_musical_interlude")],
            casterEffects: [.name("ef_tr_musical_interlude_cast")]
        ),
        .tr_mystic_symphony: .init(
            effects: [.name("ef_tr_mystic_symphony")],
            casterEffects: [.name("ef_tr_mystic_symphony_cast")]
        ),
        .tr_nipelheim_requiem: .init(
            effects: [.name("ef_tr_nipelheim_requiem")],
            casterEffects: [.name("ef_tr_nipelheim_requiem_cast")]
        ),
        .tr_pron_march: .init(
            effects: [.name("ef_tr_pron_march")],
            casterEffects: [.name("ef_tr_pron_march_cast")]
        ),
        .tr_rhythmshooting: .init(
            hitEffects: [.name("ef_tr_rhythmshooting_hit")],
            casterEffects: [.name("ef_tr_rhythmshooting_cast")]
        ),
        .tr_roki_capriccio: .init(
            effects: [.name("ef_tr_roki_capriccio")],
            casterEffects: [.name("ef_tr_roki_capriccio_cast")]
        ),
        .tr_roseblossom: .init(
            hitEffects: [.name("ef_tr_roseblossom_hit")],
            casterEffects: [.name("ef_tr_roseblossom_cast")]
        ),
    ]

    private static let skills4: [SkillID : SkillEffectDefinition] = [
        .tr_roseblossom_atk: .init(
            effects: [.name("ef_tr_roseblossom_atk")]
        ),
        .tr_soundblend: .init(
            effects: [.name("ef_tr_soundblend")],
            casterEffects: [.name("ef_tr_soundblend_cast")]
        ),
        .wa_moonlit_serenade: .init(
            effects: [.name("ef_moonlit_serenade")]
        ),
        .wa_swing_dance: .init(
            effects: [.name("ef_swing_dance")]
        ),
        .wa_symphony_of_lover: .init(
            effects: [.name("ef_symphony_of_lovers")]
        ),
        .wh_calamitygale: .init(
            casterEffects: [.name("ef_wh_calamitygale_cast")]
        ),
        .wh_crescive_bolt: .init(
            effects: [.name("ef_wh_crescive_bolt")],
            hitEffects: [.name("ef_wh_crescive_bolt_hit")],
            casterEffects: [.name("ef_wh_crescive_bolt_cast")]
        ),
        .wh_deepblindtrap: .init(
            effects: [.name("ef_wh_deepblindtrap")],
            hitEffects: [.name("ef_wh_deepblindtrap_hit")],
            casterEffects: [.name("ef_wh_deepblindtrap_cast")]
        ),
        .wh_flametrap: .init(
            effects: [.name("ef_wh_flametrap")],
            hitEffects: [.name("ef_wh_flametrap_hit")],
            casterEffects: [.name("ef_wh_flametrap_cast")]
        ),
        .wh_galestorm: .init(
            effects: [.name("ef_wh_galestorm")],
            hitEffects: [.name("ef_wh_galestorm_hit")],
            casterEffects: [.name("ef_wh_galestorm_cast")]
        ),
        .wh_hawkboomerang: .init(
            effects: [.name("ef_wh_hawkboomerang")]
        ),
        .wh_hawkrush: .init(
            effects: [.name("ef_wh_hawkrush")]
        ),
        .wh_solidtrap: .init(
            effects: [.name("ef_wh_solidtrap")],
            hitEffects: [.name("ef_wh_solidtrap_hit")],
            casterEffects: [.name("ef_wh_solidtrap_cast")]
        ),
        .wh_swifttrap: .init(
            effects: [.name("ef_wh_swifttrap")],
            hitEffects: [.name("ef_wh_swifttrap_hit")],
            casterEffects: [.name("ef_wh_swifttrap_cast")]
        ),
        .wh_wind_sign: .init(
            effects: [.name("ef_wh_wind_sign")]
        ),
        .wm_beyond_of_warcry: .init(
            effects: [.id(.ef_spr_plant7)]
        ),
        .wm_dance_with_wug: .init(
            effects: [.id(.ef_spr_plant2)]
        ),
        .wm_deadhillhere: .init(
            effects: [.name("ef_valley_of_death")]
        ),
        .wm_frigg_song: .init(
            effects: [.name("ef_frigg_song")]
        ),
        .wm_gloomyday: .init(
            effects: [.id(.ef_dance1)]
        ),
        .wm_great_echo: .init(
            effects: [.name("ef_great_echo")]
        ),
        .wm_lerads_dew: .init(
            effects: [.id(.ef_spr_plant5)]
        ),
        .wm_lullaby_deepsleep: .init(
            effects: [.id(.ef_chemical_v2)]
        ),
        .wm_melodyofsink: .init(
            effects: [.id(.ef_spr_plant6)]
        ),
        .wm_metalicsound: .init(
            effects: [.name("ef_metalicsound"), .name("ef_wm_metalicsound")],
            hitEffects: [.name("ef_wm_metalicsound_hit")]
        ),
        .wm_poemofnetherworld: .init(
            effects: [.id(.ef_bot_reverb2)]
        ),
        .wm_randomizespell: .init(
            effects: [.id(.ef_secra2)]
        ),
        .wm_reverberation: .init(
            effects: [.id(.ef_bot_reverb)]
        ),
        .wm_reverberation_magic: .init(
            hitEffects: [.name("ef_wm_reverberation_magic_hit")]
        ),
        .wm_reverberation_melee: .init(
            effects: [.id(.ef_bot_reverb2)]
        ),
        .wm_saturday_night_fever: .init(
            effects: [.id(.ef_spr_plant4)]
        ),
        .wm_severe_rainstorm: .init(
            effects: [.id(.ef_rain_particle), .name("ef_wm_severe_rainstorm")],
            casterEffects: [.name("ef_wm_severe_rainstorm_cast")]
        ),
        .wm_severe_rainstorm_melee: .init(
            effects: [.name("ef_wm_severe_rainstorm_melee")],
            casterEffects: [.name("ef_wm_severe_rainstorm_melee_cast")]
        ),
        .wm_sircleofnature: .init(
            effects: [.id(.ef_circlepower2)]
        ),
        .wm_song_of_mana: .init(
            effects: [.id(.ef_spr_plant3)]
        ),
        .wm_sound_of_destruction: .init(
            effects: [.name("ef_sound_of_destruction")],
            casterEffects: [.name("ef_wm_sound_of_destruction_cast")]
        ),
        .wm_unlimited_humming_voice: .init(
            effects: [.name("ef_wm_unlimited_humming_voice"), .id(.ef_spr_plant8)]
        ),
        .wm_voiceofsiren: .init(
            effects: [.id(.ef_heartasura)]
        ),
    ]
}
