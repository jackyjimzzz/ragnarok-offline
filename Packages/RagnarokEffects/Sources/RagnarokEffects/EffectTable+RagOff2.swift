//
//  EffectTable+RagOff2.swift
//  RagnarokEffects
//
//  [RagOff iPad Mod] Extra effects for the remaining classes (Mage, Merchant, Taekwon,
//  Gunslinger, Ninja, Summoner, expanded classes, monsters, ...).
//  Converted automatically from roBrowserLegacy EffectTable.js
//  (https://github.com/MrAntares/roBrowserLegacy/blob/master/src/DB/Effects/EffectTable.js).
//  Split into small dictionaries so each one type-checks quickly.
//

import Foundation
import RagnarokConstants
import RagnarokCore

enum RagOffEffectTable2 {
    static let idTable: [EffectID : [EffectDefinition]] = {
        var table: [EffectID : [EffectDefinition]] = [:]
        for chunk in [ids0, ids1, ids2] {
            table.merge(chunk) { first, _ in first }
        }
        return table
    }()

    static let namedTable: [String : [EffectDefinition]] = {
        var table: [String : [EffectDefinition]] = [:]
        for chunk in [named0, named1, named2, named3, named4] {
            table.merge(chunk) { first, _ in first }
        }
        return table
    }()

    private static let ids0: [EffectID : [EffectDefinition]] = [
        .ef_agiup: [
            .wav(soundName: K2L("effect\\mon_폭기.wav")),
        ],
        .ef_all_full_throttle: [
            .str(
                fileName: "all_full_throttle.str",
                soundName: "effect\\all_full_throttle.wav",
                attachedToTarget: true
            ),
        ],
        .ef_backstap: [
            .wav(soundName: "effect\\rog_back stap.wav"),
        ],
        .ef_baku: [
            .str(
                fileName: "fire dragon.str",
                soundName: K2L("effect\\폭염룡.wav"),
                attachedToTarget: false
            ),
        ],
        .ef_bash3d5: [
            .wav(soundName: "effect\\bash3d5.wav"),
            .cylinder(
                textureName: "alpha_center.tga",
                duration: 0.175,
                duplicate: EffectParameters.Duplicate(count: 6, interval: 0),
                attachedToTarget: true,
                zIndex: 1.1,
                alpha: 0.6,
                fades: true,
                topRadius: 4.5,
                bottomRadius: 0.01,
                height: 0,
                totalCircleSides: 30,
                visibleCircleSides: 1,
                animation: .growTopRadius,
                positionOffset: [0, 0, 1.5],
                rotationDegrees: [-90, 0, 0],
                rotationZRandomRange: 0...360,
                fixedPerspective: true
            ),
            .cylinder(
                textureName: "alpha_center.tga",
                duration: 0.175,
                duplicate: EffectParameters.Duplicate(count: 6, interval: 0),
                attachedToTarget: true,
                zIndex: 1.2,
                alpha: 0.6,
                fades: true,
                topRadius: 7.2,
                bottomRadius: 0.01,
                height: 0,
                totalCircleSides: 30,
                visibleCircleSides: 1,
                animation: .growTopRadius,
                positionOffset: [0, 0, 1.5],
                rotationDegrees: [-90, 0, 0],
                rotationZRandomRange: 0...360,
                fixedPerspective: true
            ),
        ],
        .ef_bleeding: [
            .str(
                fileName: "wideb.str",
                soundName: "effect\\wideb.wav",
                attachedToTarget: true
            ),
        ],
        .ef_bluecasting: [
            .cylinder(
                textureName: "ring_blue.tga",
                soundName: "effect\\ef_beginspell.wav",
                duration: 0.9,
                attachedToTarget: true,
                blendMode: .one,
                alpha: 0.8,
                fades: true,
                topRadius: 5,
                bottomRadius: 1,
                height: 4,
                animation: .growTopRadius,
                rotatesContinuously: true
            ),
        ],
        .ef_bottom_ani: [
            .wav(soundName: "effect\\chaospanic.wav"),
        ],
        .ef_bottom_basilica: [
            .cylinder(
                textureName: "alpha_down.tga",
                duration: 20,
                attachedToTarget: true,
                blendMode: .one,
                alpha: 0.12549,
                topRadius: 2.45,
                bottomRadius: 2.45,
                height: 2,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                rotatesWithCamera: true
            ),
            .cylinder(
                textureName: "alpha_down.tga",
                duration: 20,
                attachedToTarget: true,
                blendMode: .one,
                alpha: 0.12549,
                topRadius: 2.52,
                bottomRadius: 2.52,
                height: 2.1,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                rotationDegrees: [0, 10, 0],
                rotatesWithCamera: true
            ),
            .cylinder(
                textureName: "alpha_down.tga",
                duration: 20,
                attachedToTarget: true,
                blendMode: .one,
                alpha: 0.058824,
                topRadius: 2.6,
                bottomRadius: 2.6,
                height: 2,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                rotationDegrees: [0, 26.6, 0],
                rotatesWithCamera: true
            ),
            .cylinder(
                textureName: "alpha_down.tga",
                duration: 20,
                attachedToTarget: true,
                blendMode: .one,
                alpha: 0.058824,
                topRadius: 2.6,
                bottomRadius: 2.6,
                height: 2,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                rotationDegrees: [0, 79.8, 0],
                rotatesWithCamera: true
            ),
        ],
        .ef_bottom_basilica2: [
            .cylinder(
                textureName: "alpha_down.tga",
                duration: 20,
                attachedToTarget: true,
                blendMode: .one,
                alpha: 0.254902,
                topRadius: 2.2,
                bottomRadius: 2.2,
                height: 3,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                rotatesWithCamera: true
            ),
            .cylinder(
                textureName: "alpha_down.tga",
                duration: 20,
                attachedToTarget: true,
                blendMode: .one,
                alpha: 0.254902,
                topRadius: 2.25,
                bottomRadius: 2.25,
                height: 3.1,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                rotationDegrees: [0, 10, 0],
                rotatesWithCamera: true
            ),
            .cylinder(
                textureName: "alpha_down.tga",
                duration: 20,
                attachedToTarget: true,
                blendMode: .one,
                alpha: 0.058824,
                topRadius: 2.3,
                bottomRadius: 2.3,
                height: 3,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                rotatesWithCamera: true
            ),
            .cylinder(
                textureName: "alpha_down.tga",
                duration: 20,
                attachedToTarget: true,
                blendMode: .one,
                alpha: 0.058824,
                topRadius: 2.3,
                bottomRadius: 2.3,
                height: 3,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                rotationDegrees: [0, 53.2, 0],
                rotatesWithCamera: true
            ),
            .wav(soundName: "effect\\wl_whiteimprison.wav"),
        ],
        .ef_bottom_bloodylust: [
            .wav(soundName: "effect\\bloodylust.wav"),
        ],
        .ef_bottom_maelstrom: [
            .wav(soundName: "effect\\maelstrom.wav"),
        ],
        .ef_bottom_manhole: [
            .wav(soundName: "effect\\dimension.wav"),
        ],
        .ef_bullseye: [
            .str(
                fileName: K2L("불스아이.str"),
                attachedToTarget: true
            ),
        ],
        .ef_cartboost: [
            .str(
                fileName: "cart.str",
                soundName: "effect\\ef_incagility.wav",
                attachedToTarget: true
            ),
        ],
        .ef_cartrevolution: [
            .str(
                fileName: "cartrevolution.str",
                soundName: "effect\\ef_magnumbreak.wav",
                attachedToTarget: true
            ),
        ],
        .ef_chainl_str: [
            .str(
                fileName: "chainlight.str",
                soundName: "effect\\chainlight.wav",
                attachedToTarget: true
            ),
        ],
        .ef_coin: [
            .str(
                fileName: "maemor.str",
                soundName: "effect\\ef_coin2.wav",
                attachedToTarget: true
            ),
        ],
        .ef_coldthrow2: [
            .wav(soundName: "effect\\wl_jackfrost.wav"),
        ],
        .ef_crashaxe: [
            .str(
                fileName: "powerswing.str",
                attachedToTarget: true
            ),
        ],
        .ef_crashearth: [
            .str(
                fileName: "crashearth.str",
                soundName: "effect\\black_hammerfall.wav",
                attachedToTarget: false
            ),
        ],
        .ef_crimson_str: [
            .str(
                fileName: "crimson_r.str",
                soundName: "effect\\crimson_r.wav",
                attachedToTarget: true
            ),
        ],
        .ef_criticalwound: [
            .str(
                fileName: "cwound.str",
                attachedToTarget: true
            ),
        ],
        .ef_darkbreath: [
            .spr(
                fileName: "darkbreath",
                attachedToTarget: true,
                rendersAtHead: true
            ),
        ],
        .ef_deffender: [
            .str(
                fileName: "deffender.str",
                attachedToTarget: true
            ),
        ],
        .ef_demonicfire4: [
            .wav(soundName: K2L("effect\\s워머.wav")),
        ],
        .ef_demonstration: [
            .spr(
                fileName: K2L("데몬스트레이션"),
                attachedToTarget: false
            ),
        ],
        .ef_desperado: [
            .spr(
                fileName: K2L("데스페라도"),
                soundName: K2L("effect\\데스페라도.wav"),
                attachedToTarget: true
            ),
        ],
        .ef_dispell: [
            .str(
                fileName: K2L("디스펠.str"),
                attachedToTarget: true
            ),
        ],
        .ef_dragonfear: [
            .str(
                fileName: "dragon_h.str",
                soundName: "effect\\dragonfear.wav",
                attachedToTarget: true
            ),
        ],
        .ef_earthspike: [
            .wav(soundName: "effect\\wizard_earthspike.wav"),
        ],
        .ef_energycoat: [
            .str(
                fileName: "energycoat.str",
                attachedToTarget: true
            ),
        ],
        .ef_enervation: [
            .str(
                fileName: "enervation.str",
                attachedToTarget: true
            ),
        ],
        .ef_enervation2: [
            .str(
                fileName: "groomy.str",
                attachedToTarget: true
            ),
        ],
        .ef_enervation3: [
            .str(
                fileName: "ignorance.str",
                attachedToTarget: true
            ),
        ],
        .ef_enervation4: [
            .str(
                fileName: "laziness.str",
                soundName: "effect\\laziness.wav",
                attachedToTarget: true
            ),
        ],
        .ef_enervation5: [
            .str(
                fileName: "unlucky.str",
                attachedToTarget: true
            ),
        ],
        .ef_enervation6: [
            .str(
                fileName: "weakness.str",
                attachedToTarget: true
            ),
        ],
        .ef_eraser_cutter: [
            .str(
                fileName: "eraser_cutter.str",
                attachedToTarget: true
            ),
        ],
        .ef_firepillar: [
            .str(
                fileName: "firepillar.str",
                soundName: "effect\\wizard_fire_pillar_a.wav",
                attachedToTarget: false
            ),
        ],
        .ef_firepillarbomb: [
            .str(
                fileName: "firepillarbomb.str",
                soundName: "effect\\wizard_fire_pillar_b.wav",
                attachedToTarget: false
            ),
        ],
        .ef_firepillaron: [
            .cylinder(
                textureName: "magic_red.tga",
                duration: 5,
                delayOffset: 1,
                attachedToTarget: false,
                topRadius: 2,
                bottomRadius: 1,
                height: 3,
                rotatesContinuously: true
            ),
            .cylinder(
                textureName: "magic_red.tga",
                duration: 5,
                delayOffset: 1,
                attachedToTarget: false,
                topRadius: 1.5,
                bottomRadius: 0.7,
                height: 5,
                rotatesContinuously: true
            ),
            .cylinder(
                textureName: "magic_red.tga",
                duration: 5,
                delayOffset: 1,
                attachedToTarget: false,
                topRadius: 1,
                bottomRadius: 0.5,
                height: 7,
                rotatesContinuously: true
            ),
        ],
        .ef_firewall: [
            .str(
                fileName: "firewall%d.str",
                randomNumberRange: 1...2,
                attachedToTarget: false
            ),
            .wav(soundName: "effect\\ef_firewall.wav"),
        ],
        .ef_firewall2: [
            .str(
                fileName: "firewall_per.str",
                attachedToTarget: true
            ),
        ],
        .ef_flamelauncher: [
            .str(
                fileName: "enc_fire.str",
                soundName: "_enemy_hit_wind1.wav",
                attachedToTarget: true
            ),
        ],
        .ef_forestlight6: [
            .wav(soundName: "effect\\dimension.wav"),
        ],
        .ef_frostmysty: [
            .wav(soundName: K2L("effect\\t_에너지방출.wav")),
        ],
        .ef_frostweapon: [
            .str(
                fileName: "enc_ice.str",
                soundName: "_enemy_hit_wind1.wav",
                attachedToTarget: true
            ),
        ],
        .ef_gn_illusiondoping: [
            .str(
                fileName: "gn_illusiondoping.str",
                soundName: "effect\\gn_illusiondoping.wav",
                attachedToTarget: true
            ),
        ],
        .ef_guard2: [
            .wav(soundName: "effect\\black_maximize_power_sword_bic.wav"),
        ],
        .ef_guidedattack: [
            .str(
                fileName: "homing.str",
                attachedToTarget: true
            ),
        ],
        .ef_hamiblood: [
            .spr(
                fileName: K2L("블러드러스트"),
                attachedToTarget: true
            ),
        ],
        .ef_hamicastle: [
            .spr(
                fileName: K2L("캐슬링"),
                attachedToTarget: true
            ),
        ],
        .ef_hamidefence: [
            .str(
                fileName: "defense.str",
                attachedToTarget: true
            ),
        ],
        .ef_hasteup: [
            .wav(soundName: "effect\\black_adrenalinerush_b.wav"),
        ],
        .ef_hated: [
            .wav(soundName: K2L("effect\\t_보조마법.wav")),
        ],
        .ef_heavensdrive: [
            .wav(soundName: "effect\\wizard_earthspike.wav"),
        ],
        .ef_hell_str: [
            .str(
                fileName: "hell_in.str",
                attachedToTarget: true
            ),
        ],
        .ef_hyousensou: [
            .str(
                fileName: "freeze.str",
                soundName: "effect\\ef_icearrow%d.wav",
                randomNumberRange: 1...3,
                attachedToTarget: true
            ),
        ],
        .ef_hyousyouraku: [
            .str(
                fileName: "icy.str",
                soundName: K2L("effect\\빙정락.wav"),
                attachedToTarget: false
            ),
        ],
        .ef_icewall: [
            .wav(soundName: "effect\\wizard_icewall.wav"),
        ],
        .ef_intimidate: [
            .wav(soundName: "effect\\rog_intimidate.wav"),
        ],
        .ef_issen: [
            .spr(
                fileName: K2L("일섬"),
                soundName: K2L("effect\\일섬.wav"),
                attachedToTarget: true
            ),
        ],
        .ef_jumpbody: [
            .wav(soundName: K2L("effect\\t_회피2.wav")),
        ],
        .ef_jumpkick: [
            .wav(soundName: K2L("effect\\t_날라차기.wav")),
        ],
        .ef_kaen: [
            .spr(
                fileName: K2L("화염진"),
                repeats: true,
                attachedToTarget: true
            ),
            .wav(soundName: K2L("effect\\화염진.wav")),
        ],
        .ef_kaizel: [
            .wav(soundName: "effect\\priest_resurrection.wav"),
        ],
        .ef_kasumikiri: [
            .spr(
                fileName: K2L("안개베기"),
                soundName: K2L("effect\\안개베기.wav"),
                attachedToTarget: true
            ),
        ],
        .ef_keeping: [
            .str(
                fileName: "keeping.str",
                attachedToTarget: true
            ),
        ],
        .ef_kirikage: [
            .spr(
                fileName: K2L("그림자베기"),
                soundName: K2L("effect\\그림자베기.wav"),
                attachedToTarget: true
            ),
        ],
        .ef_kouenka: [
            .str(
                fileName: "firehit.str",
                soundName: "effect\\ef_firearrow%d.wav",
                randomNumberRange: 1...3,
                attachedToTarget: true
            ),
        ],
        .ef_lava_slide: [
            .str(
                fileName: "lava_slide.str",
                attachedToTarget: true
            ),
        ],
        .ef_lightningloader: [
            .str(
                fileName: "enc_wind.str",
                soundName: "effect\\_enemy_hit_wind1.wav",
                attachedToTarget: true
            ),
        ],
        .ef_linelink2: [
            .wav(soundName: K2L("effect\\소울 체인지.wav")),
        ],
        .ef_lord: [
            .str(
                fileName: "lord.str",
                soundName: "effect\\wizard_fire_ivy.wav",
                attachedToTarget: true
            ),
        ],
        .ef_loud: [
            .str(
                fileName: "loud.str",
                soundName: K2L("effect\\고성방가.wav"),
                attachedToTarget: true
            ),
        ],
        .ef_m07: [
            .spr(
                fileName: "m_ef07",
                soundName: K2L("effect\\t_보조마법.wav"),
                attachedToTarget: true
            ),
        ],
        .ef_magicalatthit: [
            .str(
                fileName: "magical.str",
                attachedToTarget: true
            ),
        ],
        .ef_magicalbullet: [
            .spr(
                fileName: K2L("매지컬불릿"),
                soundName: K2L("effect\\매지컬블릿.wav"),
                attachedToTarget: true
            ),
        ],
        .ef_magicrod: [
            .str(
                fileName: K2L("매직로드.str"),
                soundName: "effect\\sage_magic rod.wav",
                attachedToTarget: true
            ),
        ],
        .ef_manhole: [
            .wav(soundName: "effect\\manhole.wav"),
        ],
        .ef_maxpower: [
            .str(
                fileName: "maximizepower.str",
                attachedToTarget: true
            ),
        ],
        .ef_meltdown: [
            .str(
                fileName: "melt.str",
                attachedToTarget: true
            ),
        ],
        .ef_mentalbreak: [
            .str(
                fileName: "mentalbreak.str",
                attachedToTarget: true
            ),
        ],
        .ef_meteorstorm: [
            .str(
                fileName: "meteor%d.str",
                soundName: "effect\\wizard_meteor.wav",
                randomNumberRange: 1...4,
                attachedToTarget: true
            ),
        ],
        .ef_midnight_frenzy: [
            .str(
                fileName: "mid_frenzy.str",
                attachedToTarget: true
            ),
        ],
        .ef_nc_magma_eruption: [
            .str(
                fileName: "nc_magma_eruption.str",
                soundName: "effect\\nc_magma_eruption.wav",
                attachedToTarget: true
            ),
        ],
    ]

    private static let ids1: [EffectID : [EffectDefinition]] = [
        .ef_npc_earthquake: [
            .spr(
                fileName: K2L("어스퀘이크"),
                soundName: "effect\\earth_quake.wav",
                attachedToTarget: true
            ),
        ],
        .ef_npc_stop: [
            .spr(
                fileName: K2L("스톱"),
                attachedToTarget: true
            ),
        ],
        .ef_npc_stop2: [
            .spr(
                fileName: "cconfine",
                soundName: "effect\\ef_hit6.wav",
                stopsAtEnd: true,
                attachedToTarget: true
            ),
        ],
        .ef_overthrust: [
            .wav(soundName: "effect\\black_overthrust.wav"),
        ],
        .ef_perfection: [
            .str(
                fileName: "weaponperfection.str",
                soundName: "effect\\black_weapon_perfection.wav",
                attachedToTarget: true
            ),
        ],
        .ef_petrifyattack: [
            .str(
                fileName: "stonecurse.str",
                attachedToTarget: true
            ),
        ],
        .ef_poison_mist: [
            .str(
                fileName: "poison_mist.str",
                attachedToTarget: true
            ),
        ],
        .ef_poisonattack: [
            .str(
                fileName: "poison.str",
                attachedToTarget: true
            ),
        ],
        .ef_poisonhit: [
            .spr(
                fileName: "poisonhit",
                soundName: "effect\\ef_poisonattack.wav",
                attachedToTarget: false
            ),
        ],
        .ef_potion_berserk: [
            .str(
                fileName: K2L("버서크.str"),
                soundName: "effect\\ac_concentration.wav",
                attachedToTarget: true
            ),
        ],
        .ef_pressure3: [
            .`3D`(
                kind: .texture("effect\\cross1.bmp"),
                soundName: K2L("effect\\프레셔.wav"),
                duration: 0.5,
                attachedToTarget: true,
                zIndex: 1,
                blendMode: .one,
                alphaMax: 0.6,
                positionStart: [0, 0, 20],
                positionEnd: [0, 0, 5],
                targetAngle: -611,
                rotates: true
            ),
            .`3D`(
                kind: .texture("effect\\cross1.bmp"),
                duration: 0.5,
                delayOffset: 0.501,
                attachedToTarget: true,
                zIndex: 1,
                blendMode: .one,
                alphaMax: 0.6,
                fadesOut: true,
                offset: [0, 0, 5],
                angle: -611
            ),
        ],
        .ef_quagmire: [
            .str(
                fileName: "quagmire.str",
                attachedToTarget: false
            ),
            .wav(soundName: "effect\\wizard_quagmire.wav"),
        ],
        .ef_rapidshower: [
            .spr(
                fileName: K2L("래피드샤워"),
                soundName: K2L("effect\\래피드샤워.wav"),
                attachedToTarget: true
            ),
        ],
        .ef_recognized: [
            .wav(soundName: "effect\\wl_recognizedspell.wav"),
        ],
        .ef_rejectsword: [
            .str(
                fileName: "sword.str",
                soundName: "effect\\kyrie_guard.wav",
                attachedToTarget: true
            ),
        ],
        .ef_repairweapon: [
            .str(
                fileName: "repairweapon.str",
                attachedToTarget: true
            ),
            .wav(soundName: "effect\\black_weapon_repair_a.wav", delaySound: 0.48),
            .wav(soundName: "effect\\black_weapon_repair_a.wav", delaySound: 1.32),
        ],
        .ef_rg_coin: [
            .wav(soundName: "effect\\rog_steal coin.wav"),
        ],
        .ef_rg_coin3: [
            .wav(soundName: K2L("effect\\디스암.wav")),
        ],
        .ef_seismicweapon: [
            .str(
                fileName: "enc_earth.str",
                soundName: "_enemy_hit_wind1.wav",
                attachedToTarget: true
            ),
        ],
        .ef_shockwave2: [
            .str(
                fileName: "hunter_shockwave_blue.str",
                attachedToTarget: true
            ),
        ],
        .ef_sightrasher: [
            .`3D`(
                kind: .sprite(K2L("이팩트\\sight"), playSprite: true),
                duration: 0.8,
                duplicate: EffectParameters.Duplicate(count: 4, interval: 0.1, alphaMaxDelta: 0.011765, sizeDelta: -60),
                attachedToTarget: false,
                alphaMax: 0.482353,
                fadesIn: true,
                fadesOut: true,
                positionStart: [0, 0, 2],
                positionEnd: [0, -8, 2],
                sizeStart: [20, 20],
                sizeEnd: [260, 260]
            ),
            .`3D`(
                kind: .sprite(K2L("이팩트\\sight"), playSprite: true),
                duration: 0.8,
                duplicate: EffectParameters.Duplicate(count: 4, interval: 0.1, alphaMaxDelta: 0.011765, sizeDelta: -60),
                attachedToTarget: false,
                alphaMax: 0.482353,
                fadesIn: true,
                fadesOut: true,
                positionStart: [0, 0, 2],
                positionEnd: [5.66, -5.66, 2],
                sizeStart: [20, 20],
                sizeEnd: [260, 260]
            ),
            .`3D`(
                kind: .sprite(K2L("이팩트\\sight"), playSprite: true),
                duration: 0.8,
                duplicate: EffectParameters.Duplicate(count: 4, interval: 0.1, alphaMaxDelta: 0.011765, sizeDelta: -60),
                attachedToTarget: false,
                alphaMax: 0.482353,
                fadesIn: true,
                fadesOut: true,
                positionStart: [0, 0, 2],
                positionEnd: [8, 0, 2],
                sizeStart: [20, 20],
                sizeEnd: [260, 260]
            ),
            .`3D`(
                kind: .sprite(K2L("이팩트\\sight"), playSprite: true),
                duration: 0.8,
                duplicate: EffectParameters.Duplicate(count: 4, interval: 0.1, alphaMaxDelta: 0.011765, sizeDelta: -60),
                attachedToTarget: false,
                alphaMax: 0.482353,
                fadesIn: true,
                fadesOut: true,
                positionStart: [0, 0, 2],
                positionEnd: [5.66, 5.66, 2],
                sizeStart: [20, 20],
                sizeEnd: [260, 260]
            ),
            .`3D`(
                kind: .sprite(K2L("이팩트\\sight"), playSprite: true),
                duration: 0.8,
                duplicate: EffectParameters.Duplicate(count: 4, interval: 0.1, alphaMaxDelta: 0.011765, sizeDelta: -60),
                attachedToTarget: false,
                alphaMax: 0.482353,
                fadesIn: true,
                fadesOut: true,
                positionStart: [0, 0, 2],
                positionEnd: [0, 8, 2],
                sizeStart: [20, 20],
                sizeEnd: [260, 260]
            ),
            .`3D`(
                kind: .sprite(K2L("이팩트\\sight"), playSprite: true),
                duration: 0.8,
                duplicate: EffectParameters.Duplicate(count: 4, interval: 0.1, alphaMaxDelta: 0.011765, sizeDelta: -60),
                attachedToTarget: false,
                alphaMax: 0.482353,
                fadesIn: true,
                fadesOut: true,
                positionStart: [0, 0, 2],
                positionEnd: [-5.66, 5.66, 2],
                sizeStart: [20, 20],
                sizeEnd: [260, 260]
            ),
            .`3D`(
                kind: .sprite(K2L("이팩트\\sight"), playSprite: true),
                duration: 0.8,
                duplicate: EffectParameters.Duplicate(count: 4, interval: 0.1, alphaMaxDelta: 0.011765, sizeDelta: -60),
                attachedToTarget: false,
                alphaMax: 0.482353,
                fadesIn: true,
                fadesOut: true,
                positionStart: [0, 0, 2],
                positionEnd: [-8, 0, 2],
                sizeStart: [20, 20],
                sizeEnd: [260, 260]
            ),
            .`3D`(
                kind: .sprite(K2L("이팩트\\sight"), playSprite: true),
                duration: 0.8,
                duplicate: EffectParameters.Duplicate(count: 4, interval: 0.1, alphaMaxDelta: 0.011765, sizeDelta: -60),
                attachedToTarget: false,
                alphaMax: 0.482353,
                fadesIn: true,
                fadesOut: true,
                positionStart: [0, 0, 2],
                positionEnd: [-5.66, -5.66, 2],
                sizeStart: [20, 20],
                sizeEnd: [260, 260]
            ),
            .wav(soundName: "effect\\wizard_sightrasher.wav"),
        ],
        .ef_silenceattack: [
            .str(
                fileName: "silence.str",
                attachedToTarget: true
            ),
        ],
        .ef_sleepattack: [
            .str(
                fileName: "sleep.str",
                attachedToTarget: true
            ),
        ],
        .ef_so_elemental_shield: [
            .str(
                fileName: "so_elemental_shield.str",
                soundName: "effect\\so_elemental_shield.wav",
                attachedToTarget: true
            ),
        ],
        .ef_sonic_claw: [
            .str(
                fileName: "sonic_claw.str",
                attachedToTarget: true
            ),
        ],
        .ef_soulburn: [
            .str(
                fileName: K2L("소울번.str"),
                attachedToTarget: true
            ),
        ],
        .ef_soulstrike2: [
            .`3D`(
                kind: .texture("effect\\pok3.tga"),
                soundName: "effect\\ef_soulstrike.wav",
                duration: 0.2,
                delayLate: 0.25,
                attachedToTarget: true,
                zIndex: 1,
                fadesIn: true,
                fadesOut: true,
                positionEnd: [0, 0, 1],
                positionStartZRandomRange: 1...11,
                smoothPositionAxes: EffectAxes(x: false, y: false, z: true),
                movesToSource: true,
                size: [50, 50]
            ),
        ],
        .ef_spellbreaker: [
            .str(
                fileName: "spell.str",
                soundName: "effect\\sage_spell breake.wav",
                attachedToTarget: true
            ),
        ],
        .ef_spr_mash: [
            .spr(
                fileName: "mashofa",
                attachedToTarget: false
            ),
        ],
        .ef_spr_plant10: [
            .wav(soundName: K2L("effect\\s사이킥웨이브.wav")),
        ],
        .ef_stasis: [
            .wav(soundName: "effect\\wl_stasis.wav"),
        ],
        .ef_stealcoin: [
            .str(
                fileName: "steal_coin.str",
                attachedToTarget: true
            ),
        ],
        .ef_stin: [
            .wav(soundName: K2L("effect\\t_에너지방출.wav")),
        ],
        .ef_stin3: [
            .wav(soundName: K2L("effect\\t_에너지방출.wav")),
        ],
        .ef_stin4: [
            .wav(soundName: K2L("effect\\풍인.wav")),
        ],
        .ef_stonecurse: [
            .str(
                fileName: "stonecurse.str",
                attachedToTarget: true
            ),
        ],
        .ef_stormgust: [
            .str(
                fileName: "stormgust.str",
                soundName: "effect\\wizard_stormgust.wav",
                attachedToTarget: true
            ),
        ],
        .ef_stretch: [
            .wav(soundName: "effect\\bodypaint.wav"),
        ],
        .ef_striparmor: [
            .str(
                fileName: "strip_armor.str",
                soundName: K2L("effect\\t_벽튕김.wav"),
                attachedToTarget: true
            ),
        ],
        .ef_striphelm: [
            .str(
                fileName: "strip_helm.str",
                soundName: K2L("effect\\t_벽튕김.wav"),
                attachedToTarget: true
            ),
        ],
        .ef_stripshield: [
            .str(
                fileName: "strip_shield.str",
                soundName: K2L("effect\\t_벽튕김.wav"),
                attachedToTarget: true
            ),
        ],
        .ef_stripweapon: [
            .str(
                fileName: "strip_weapon.str",
                soundName: K2L("effect\\t_벽튕김.wav"),
                attachedToTarget: true
            ),
        ],
        .ef_stunattack: [
            .str(
                fileName: "stun.str",
                attachedToTarget: true
            ),
        ],
        .ef_sui_explosion: [
            .str(
                fileName: "sui_explosion.str",
                soundName: "effect\\ef_hit2.wav",
                attachedToTarget: true
            ),
        ],
        .ef_suicide: [
            .str(
                fileName: "suicide.str",
                attachedToTarget: true
            ),
        ],
        .ef_tatami: [
            .spr(
                fileName: K2L("다다미 뒤집기"),
                soundName: K2L("effect\\다다미뒤집기.wav"),
                attachedToTarget: true
            ),
        ],
        .ef_teihit1x: [
            .`3D`(
                kind: .texture("effect\\lens1.tga"),
                soundName: K2L("effect\\mon_아수라 패황권.wav"),
                duration: 0.55,
                delayStart: 0.1,
                duplicate: EffectParameters.Duplicate(count: 24, interval: 0),
                attachedToTarget: true,
                overlay: true,
                blendMode: .one,
                alphaMax: 0.8,
                fadesIn: true,
                fadesOut: true,
                positionEndXRandomRange: -40...40,
                positionEndYRandomRange: -40...40,
                sizeStart: [10, 150],
                sizeEnd: [10, 150],
                rotatesToTarget: true,
                rotatesWithCamera: true
            ),
        ],
        .ef_teihit3: [
            .`3D`(
                kind: .texture("effect\\lens1.tga"),
                duration: 0.55,
                delayStart: 0.1,
                duplicate: EffectParameters.Duplicate(count: 20, interval: 0),
                attachedToTarget: true,
                overlay: true,
                blendMode: .one,
                color: [0.1, 0.1, 1],
                alphaMax: 0.8,
                fadesIn: true,
                fadesOut: true,
                positionEndXRandomRange: -40...40,
                positionEndYRandomRange: -40...40,
                sizeStart: [10, 150],
                sizeEnd: [10, 150],
                rotatesToTarget: true,
                rotatesWithCamera: true
            ),
        ],
        .ef_tetra: [
            .wav(soundName: "effect\\wl_tetravortex.wav"),
        ],
        .ef_throwitem: [
            .`3D`(
                kind: .texture(K2L("유저인터페이스\\item\\염산병.bmp")),
                duration: 0.3,
                attachedToTarget: true,
                zIndex: 1,
                fadesIn: true,
                fadesOut: true,
                zOffsetStart: 1,
                zOffsetEnd: 1,
                movesToSource: true,
                size: [30, 30],
                angle: 180,
                rotates: true,
                rotationCount: 0.5,
                rotatesToTarget: true,
                rotatesWithCamera: true
            ),
        ],
        .ef_throwitem10: [
            .wav(soundName: K2L("effect\\닌자_던지기.wav")),
            .`3D`(
                kind: .texture("effect\\coin_a.bmp"),
                duration: 0.2,
                attachedToTarget: true,
                zIndex: 1,
                fadesIn: true,
                fadesOut: true,
                zOffsetStart: 1,
                zOffsetEnd: 1,
                movesToSource: true,
                size: [20, 20],
                angle: 180,
                rotates: true,
                rotationCount: 1,
                rotatesToTarget: true,
                rotatesWithCamera: true
            ),
        ],
        .ef_throwitem7: [
            .wav(soundName: K2L("effect\\닌자_던지기.wav")),
            .`3D`(
                kind: .texture(K2L("유저인터페이스\\item\\수리검.bmp")),
                duration: 0.2,
                attachedToTarget: true,
                zIndex: 1,
                fadesIn: true,
                fadesOut: true,
                zOffsetStart: 1,
                zOffsetEnd: 1,
                movesToSource: true,
                size: [30, 30],
                angle: 180,
                rotates: true,
                rotationCount: 1,
                rotatesToTarget: true,
                rotatesWithCamera: true
            ),
        ],
        .ef_throwitem8: [
            .wav(soundName: K2L("effect\\닌자_던지기.wav")),
            .`3D`(
                kind: .texture(K2L("유저인터페이스\\item\\쿠나이_독.bmp")),
                duration: 0.2,
                attachedToTarget: true,
                zIndex: 1,
                fadesIn: true,
                fadesOut: true,
                zOffsetStart: 1,
                zOffsetEnd: 1,
                movesToSource: true,
                size: [30, 30],
                angle: 180,
                rotates: true,
                rotationCount: 1,
                rotatesToTarget: true,
                rotatesWithCamera: true
            ),
        ],
        .ef_throwitem9: [
            .wav(soundName: K2L("effect\\닌자_던지기.wav")),
            .`3D`(
                kind: .texture(K2L("유저인터페이스\\item\\풍마_뇌우.bmp")),
                duration: 0.2,
                attachedToTarget: true,
                zIndex: 1,
                fadesIn: true,
                fadesOut: true,
                zOffsetStart: 1,
                zOffsetEnd: 1,
                movesToSource: true,
                size: [30, 30],
                angle: 180,
                rotates: true,
                rotationCount: 1,
                rotatesToTarget: true,
                rotatesWithCamera: true
            ),
        ],
        .ef_thunderstorm2: [
            .str(
                fileName: "setsudan.str",
                soundName: "effect\\ef_thunderstorm.wav",
                attachedToTarget: true
            ),
        ],
        .ef_tinder_breaker: [
            .str(
                fileName: "tinder.str",
                attachedToTarget: true
            ),
        ],
        .ef_trackcasting: [
            .str(
                fileName: K2L("트랙킹.str"),
                attachedToTarget: true
            ),
        ],
        .ef_tracking: [
            .spr(
                fileName: K2L("트래킹"),
                attachedToTarget: true
            ),
        ],
        .ef_tripleaction: [
            .spr(
                fileName: K2L("트리플액션"),
                soundName: K2L("effect\\트리플액션.wav"),
                attachedToTarget: true
            ),
        ],
        .ef_venomfog: [
            .str(
                fileName: "bubble%d_1.str",
                randomNumberRange: 1...4,
                attachedToTarget: true
            ),
        ],
        .ef_volcanic_ash: [
            .str(
                fileName: "vash00.str",
                attachedToTarget: true
            ),
        ],
        .ef_wewish: [
            .str(
                fileName: "angelus.str",
                soundName: "effect\\wewish.wav",
                attachedToTarget: true
            ),
        ],
        .ef_wl_telekinesis_intense: [
            .str(
                fileName: "wl_telekinesis_intense.str",
                soundName: "effect\\wl_telekinesis_intense.wav",
                attachedToTarget: true
            ),
        ],
    ]

    private static let ids2: [EffectID : [EffectDefinition]] = [
        .ef_yufitel: [
            .wav(soundName: "effect\\hunter_shockwavetrap.wav"),
            .`3D`(
                kind: .texture("effect\\thunder_center.bmp"),
                duration: 0.2,
                attachedToTarget: false,
                overlay: true,
                blendMode: .one,
                alphaMax: 0.66,
                movesToSource: true,
                size: [35, 35]
            ),
        ],
        .ef_yufitelhit: [
            .`3D`(
                kind: .texture("effect\\thunder_pang.bmp"),
                duration: 0.1,
                attachedToTarget: true,
                overlay: true,
                blendMode: .one,
                fadesOut: true,
                sizeStart: [0, 0],
                sizeEnd: [25, 25],
                rotatesToTarget: true
            ),
        ],
    ]

    private static let named0: [String : [EffectDefinition]] = [
        "98_beforecast": [
            .wav(soundName: "effect\\black_adrenalinerush_a.wav"),
        ],
        "ef_abc_abyss_dagger": [
            .str(
                fileName: "abyss_dagger\\abyss_dagger\\abyss_dagger.str",
                soundName: "effect\\abc_abyss_dagger.wav",
                attachedToTarget: false
            ),
        ],
        "ef_abc_abyss_dagger_hit": [
            .str(
                fileName: "abyss_dagger\\abyss_dagger_hit\\abyss_dagger_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_abc_abyss_slayer": [
            .str(
                fileName: "4abc_abyss_slayer\\abyss_slayer\\abyss_slayer.str",
                soundName: "effect\\abc_abyss_slayer.wav",
                attachedToTarget: false
            ),
        ],
        "ef_abc_abyss_slayer_cast": [
            .str(
                fileName: "4abc_abyss_slayer\\abyss_slayer_cast\\abyss_slayer_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "4abc_abyss_slayer\\abyss_slayer_cast_bottom\\abyss_slayer_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_abc_abyss_square": [
            .str(
                fileName: "abyss_square\\abyss_square\\abyss_square.str",
                soundName: "effect\\abc_abyss_square.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "abyss_square\\abyss_square_bottom\\abyss_square_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_abc_abyss_square_hit": [
            .str(
                fileName: "abyss_square\\abyss_square_hit\\abyss_square_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_abc_abyss_strike": [
            .str(
                fileName: "abyss_strike\\abyss_strike\\abyss_strike.str",
                soundName: "effect\\abc_abyss_strike.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "abyss_strike\\abyss_strike_bottom\\abyss_strike_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_abc_abyss_strike_cast": [
            .str(
                fileName: "abyss_strike\\abyss_strike_cast\\abyss_strike_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "abyss_strike\\abyss_strike_cast_bottom\\abyss_strike_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_abc_abyss_strike_hit": [
            .str(
                fileName: "abyss_strike\\abyss_strike_hit\\abyss_strike_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_abc_chain_reaction_shot": [
            .str(
                fileName: "chain_reaction_shot\\chain_reaction_shot\\chain_reaction_shot.str",
                soundName: "effect\\abc_chain_reaction_shot.wav",
                attachedToTarget: false
            ),
        ],
        "ef_abc_chain_reaction_shot_atk": [
            .str(
                fileName: "chain_reaction_shot\\chain_reaction_shot_hit\\chain_reaction_shot_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_abc_chain_reaction_shot_cast": [
            .str(
                fileName: "chain_reaction_shot\\chain_reaction_shot_cast\\chain_reaction_shot_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "chain_reaction_shot\\chain_reaction_shot_cast_bottom\\chain_reaction_shot_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_abc_chain_reaction_shot_hit": [
            .str(
                fileName: "chain_reaction_shot\\chain_reaction_shot_hit\\chain_reaction_shot_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_abc_deft_stab": [
            .str(
                fileName: "deft_stab\\deft_stab\\deft_stab.str",
                attachedToTarget: false
            ),
        ],
        "ef_abc_frenzy_shot": [
            .str(
                fileName: "frenzy_shot\\frenzy_shot\\frenzy_shot.str",
                soundName: "effect\\abc_frenzy_shot.wav",
                attachedToTarget: false
            ),
        ],
        "ef_abc_frenzy_shot_hit": [
            .str(
                fileName: "frenzy_shot\\frenzy_shot_hit\\frenzy_shot_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_abc_from_the_abyss_atk": [
            .str(
                fileName: "from_the_abyss\\from_the_abyss_attack\\from_the_abyss_attack.str",
                attachedToTarget: false
            ),
        ],
        "ef_abc_from_the_abyss_hit": [
            .str(
                fileName: "from_the_abyss\\from_the_abyss_attack\\from_the_abyss_attack.str",
                soundName: "effect\\abc_from_the_abyss.wav",
                attachedToTarget: false
            ),
        ],
        "ef_abc_unlucky_rush": [
            .str(
                fileName: "unlucky_rush\\unlucky_rush\\unlucky_rush.str",
                soundName: "effect\\abc_unlucky_rush.wav",
                attachedToTarget: false
            ),
        ],
        "ef_abc_unlucky_rush_cast": [
            .str(
                fileName: "unlucky_rush\\unlucky_rush_cast\\unlucky_rush_cast.str",
                attachedToTarget: false
            ),
        ],
        "ef_abc_unlucky_rush_hit": [
            .str(
                fileName: "unlucky_rush\\unlucky_rush_hit\\unlucky_rush_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_all_bloom": [
            .str(
                fileName: "allbloom\\allbloom\\allbloom.str",
                soundName: "effect\\ag_all_bloom.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "allbloom\\allbloom_bottom\\allbloom_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_all_bloom_atk": [
            .str(
                fileName: "allbloom\\allbloom_hit\\allbloom_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_all_bloom_atk2": [
            .str(
                fileName: "allbloom\\allbloom_hit\\allbloom_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_all_bloom_cast": [
            .str(
                fileName: "allbloom\\allbloom_cast\\allbloom_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "allbloom\\allbloom_cast_bottom\\allbloom_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_all_bloom_hit": [
            .str(
                fileName: "allbloom\\allbloom_hit\\allbloom_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_astral_strike": [
            .str(
                fileName: "astralstrike\\astralstrike\\astralstrike.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "astralstrike\\astralstrike_bottom\\astralstrike_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_astral_strike_cast": [
            .str(
                fileName: "astralstrike\\astralstrike_cast\\astralstrike_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "astralstrike\\astralstrike_cast_bottom\\astralstrike_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_climax": [
            .str(
                fileName: "climax\\climax\\climax.str",
                soundName: "effect\\ag_climax.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "climax\\climax_bottom\\climax_bottom_%d.str",
                randomNumberRange: 1...5,
                attachedToTarget: false
            ),
        ],
        "ef_ag_climax_cast": [
            .str(
                fileName: "climax\\climax_cast\\climax_cast.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_crimson_arrow": [
            .str(
                fileName: "crimsonarrow\\crimsonarrow\\crimsonarrow.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_crimson_arrow_atk": [
            .str(
                fileName: "crimsonarrow\\crimsonarrow_hit\\crimsonarrow_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_crimson_arrow_cast": [
            .str(
                fileName: "crimsonarrow\\crimsonarrow_cast\\crimsonarrow_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "crimsonarrow\\crimsonarrow_cast_bottom\\crimsonarrow_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_crimson_arrow_hit": [
            .str(
                fileName: "crimsonarrow\\crimsonarrow_hit\\crimsonarrow_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_crystal_impact": [
            .str(
                fileName: "crystal_impact\\crystal_impact\\crystal_impact.str",
                soundName: "effect\\ag_crystal_impact.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "crystal_impact\\crystal_impact_buff\\crystal_impact_buff.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "crystal_impact\\crystal_impact_bottom\\crystal_impact_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_crystal_impact_atk": [
            .str(
                fileName: "crystal_impact\\crystal_impact_hit\\crystal_impact_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_crystal_impact_cast": [
            .str(
                fileName: "crystal_impact\\crystal_impact_cast\\crystal_impact_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "crystal_impact\\crystal_impact_cast_bottom\\crystal_impact_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_crystal_impact_hit": [
            .str(
                fileName: "crystal_impact\\crystal_impact_hit\\crystal_impact_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_deadly_projection_cast": [
            .str(
                fileName: "deadly_projection\\deadly_projection_cast\\deadly_projection_cast.str",
                soundName: "effect\\ag_deadly_projection.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "deadly_projection\\deadly_projection_cast_bottom\\deadly_projection_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_deadly_projection_hit": [
            .str(
                fileName: "deadly_projection\\deadly_projection_hit\\deadly_projection_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_destructive_hurricane": [
            .str(
                fileName: "destructive_hurricane\\destructive_hurricane\\destructive_hurricane.str",
                soundName: "effect\\ag_destructive_hurricane.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "destructive_hurricane\\destructive_hurricane_bottom\\destructive_hurricane_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_destructive_hurricane_cast": [
            .str(
                fileName: "destructive_hurricane\\destructive_hurricane_cast\\destructive_hurricane_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "destructive_hurricane\\destructive_hurricane_cast_bottom\\destructive_hurricane_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_destructive_hurricane_hit": [
            .str(
                fileName: "destructive_hurricane\\destructive_hurricane_hit\\destructive_hurricane_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_frozen_slash": [
            .str(
                fileName: "frozen_slash\\frozen_slash\\frozen_slash.str",
                soundName: "effect\\ag_frozen_slash.wav",
                attachedToTarget: false
            ),
        ],
        "ef_ag_frozen_slash_cast": [
            .str(
                fileName: "frozen_slash\\frozen_slash_casting\\frozen_slash_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "frozen_slash\\frozen_slash_casting_bottom\\frozen_slash_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_frozen_slash_hit": [
            .str(
                fileName: "frozen_slash\\frozen_slash_hit\\frozen_slash_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_mystery_illusion": [
            .str(
                fileName: "mystery_illusion\\mystery_illusion\\mystery_illusion.str",
                soundName: "effect\\ag_mystery_illusion.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "mystery_illusion\\mystery_illusion_bottom\\mystery_illusion_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_mystery_illusion_cast": [
            .str(
                fileName: "mystery_illusion\\mystery_illusion_cast\\mystery_illusion_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "mystery_illusion\\mystery_illusion_cast_bottom\\mystery_illusion_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_mystery_illusion_hit": [
            .str(
                fileName: "mystery_illusion\\mystery_illusion_hit\\mystery_illusion_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_rain_of_crystal_cast": [
            .str(
                fileName: "rain_of_crystal\\rain_of_crystal_casting\\rain_of_crystal_casting.str",
                soundName: "effect\\ag_rain_of_crystal.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "rain_of_crystal\\rain_of_crystal_casting_bottom\\rain_of_crystal_casting_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_rain_of_crystal_hit": [
            .str(
                fileName: "rain_of_crystal\\rain_of_crystal_attack\\rain_of_crystal_attack.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "rain_of_crystal\\rain_of_crystal_attack_bottom\\rain_of_crystal_attack_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_rock_down": [
            .str(
                fileName: "rockdown\\rockdown\\rockdown.str",
                soundName: "effect\\ag_rock_down.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "rockdown\\rockdown_bottom\\rockdown_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_rock_down_cast": [
            .str(
                fileName: "rockdown\\rockdown_cast\\rockdown_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "rockdown\\rockdown_cast_bottom\\rockdown_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_rock_down_hit": [
            .str(
                fileName: "rockdown\\rockdown_hit\\rockdown_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_soul_vc_strike_cast": [
            .str(
                fileName: "soul_vc_strike\\soul_vc_strike_cast\\soul_vc_strike_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "soul_vc_strike\\soul_vc_strike_cast_bottom\\soul_vc_strike_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_soul_vc_strike_hit": [
            .str(
                fileName: "soul_vc_strike\\soul_vc_strike_hit\\soul_vc_strike_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_storm_cannon": [
            .str(
                fileName: "stormcannon\\stormcannon\\stormcannon.str",
                soundName: "effect\\ag_storm_cannon.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "stormcannon\\stormcannon_bottom\\stormcannon_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_storm_cannon_cast": [
            .str(
                fileName: "stormcannon\\stormcannon_cast_bottom\\stormcannon_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_strantum_tremor": [
            .str(
                fileName: "new_strantumtremor\\new_strantumtremor\\new_strantumtremor.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_strantumtremor\\new_strantumtremor_bottom\\new_strantumtremor_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_strantum_tremor_cast": [
            .str(
                fileName: "new_strantumtremor\\new_strantumtremor_cast\\new_strantumtremor_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_strantumtremor\\new_strantumtremor_cast_bottom\\new_strantumtremor_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_strantum_tremor_hit": [
            .str(
                fileName: "new_strantumtremor\\new_strantumtremor_hit\\new_strantumtremor_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_tornado_storm": [
            .str(
                fileName: "new_tornadostorm\\new_tornadostorm\\new_tornadostorm.str",
                soundName: "effect\\ag_tornado_storm.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_tornadostorm\\new_tornadostorm_bottom\\new_tornadostorm_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_tornado_storm_cast": [
            .str(
                fileName: "new_tornadostorm\\new_tornadostorm_cast\\new_tornadostorm_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_tornadostorm\\new_tornadostorm_cast_bottom\\new_tornadostorm_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_tornado_storm_hit": [
            .str(
                fileName: "new_tornadostorm\\new_tornadostorm_hit\\new_tornadostorm_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_violent_quake": [
            .str(
                fileName: "violentquake\\violentquake\\violentquake_01.str",
                soundName: "effect\\ag_violent_quake.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "violentquake\\violentquake_bottom\\violentquake_bottom.str",
                attachedToTarget: false
            ),
        ],
    ]

    private static let named1: [String : [EffectDefinition]] = [
        "ef_ag_violent_quake_atk": [
            .str(
                fileName: "violentquake\\violentquake_hit\\violentquake_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_violent_quake_cast": [
            .str(
                fileName: "violentquake\\violentquake_cast\\violentquake_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "violentquake\\violentquake_cast_bottom\\violentquake_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ag_violent_quake_hit": [
            .str(
                fileName: "violentquake\\violentquake_hit\\violentquake_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_bo_acidified_zone_fire_cast": [
            .str(
                fileName: "acidified_zone_fire\\acidified_zone_fire_cast\\acidified_zone_fire_cast.str",
                soundName: "effect\\bo_acidified_zone_fire.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "acidified_zone_fire\\acidified_zone_fire_cast_bottom\\acidified_zone_fire_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_bo_acidified_zone_fire_hit": [
            .str(
                fileName: "acidified_zone_fire\\acidified_zone_fire_hit\\acidified_zone_fire_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_bo_acidified_zone_ground_cast": [
            .str(
                fileName: "acidified_zone_ground\\acidified_zone_ground_cast\\acidified_zone_ground_cast.str",
                soundName: "effect\\bo_acidified_zone_ground.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "acidified_zone_ground\\acidified_zone_ground_cast_bottom\\acidified_zone_ground_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_bo_acidified_zone_ground_hit": [
            .str(
                fileName: "acidified_zone_ground\\acidified_zone_ground_hit\\acidified_zone_ground_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_bo_acidified_zone_water_cast": [
            .str(
                fileName: "acidified_zone_water\\acidified_zone_water_cast\\acidified_zone_water_cast.str",
                soundName: "effect\\bo_acidified_zone_water.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "acidified_zone_water\\acidified_zone_water_cast_bottom\\acidified_zone_water_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_bo_acidified_zone_water_hit": [
            .str(
                fileName: "acidified_zone_water\\acidified_zone_water_hit\\acidified_zone_water_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_bo_acidified_zone_wind_cast": [
            .str(
                fileName: "acidified_zone_wind\\acidified_zone_wind_cast\\acidified_zone_wind_cast.str",
                soundName: "effect\\bo_acidified_zone_wind.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "acidified_zone_wind\\acidified_zone_wind_cast_bottom\\acidified_zone_wind_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_bo_acidified_zone_wind_hit": [
            .str(
                fileName: "acidified_zone_wind\\acidified_zone_wind_hit\\acidified_zone_wind_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_bo_advance_protection": [
            .wav(soundName: "effect\\bo_advance_protection.wav"),
        ],
        "ef_bo_explosive_powder": [
            .str(
                fileName: "biolo\\explosive_powder\\explosive_powder\\explosive_powder.str",
                soundName: "effect\\bo_explosive_powder.wav",
                attachedToTarget: false
            ),
        ],
        "ef_bo_helltree_cast": [
            .str(
                fileName: "helltree\\helltree_cast\\helltree_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "helltree\\helltree_cast_bottom\\helltree_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_bo_mayhemic_thorns": [
            .str(
                fileName: "biolo\\mayhemic_thorns\\mayhemic_thorns\\mayhemic_thorns.str",
                soundName: "effect\\bo_mayhemic_thorns.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "biolo\\mayhemic_thorns\\mayhemic_thorns_bottom\\mayhemic_thorns_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_bo_researchreport": [
            .str(
                fileName: "research_report\\researchreport\\researchreport.str",
                soundName: "effect\\bo_researchreport.wav",
                attachedToTarget: false
            ),
        ],
        "ef_bo_researchreport_cast": [
            .str(
                fileName: "research_report\\researchreport_cast\\researchreport_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "research_report\\researchreport_cast_bottom\\researchreport_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_bo_wooden_fairy_cast": [
            .str(
                fileName: "wooden_fairy\\wooden_cast\\wooden_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "wooden_fairy\\wooden_cast_bottom\\wooden_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_bo_woodenwarrior_cast": [
            .str(
                fileName: "wooden_warrior\\wooden_warrior_cast\\wooden_warrior_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "wooden_warrior\\wooden_warrior_cast_bottom\\wooden_warrior_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_bo_woodenwarrior_hit": [
            .str(
                fileName: "wooden_warrior\\throwrock\\throwrock_hit\\throwrock_hit.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "wooden_warrior\\wooden_attack\\wooden_attack\\wooden_attack.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "wooden_warrior\\wooden_attack\\wooden_attack_hit\\wooden_attack_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_bs_adrenaline2": [
            .str(
                fileName: "adrenaline.str",
                attachedToTarget: false
            ),
        ],
        "ef_c_marker1": [
            .str(
                fileName: "RL_C_MAKER\\deffender.str",
                attachedToTarget: true
            ),
            .str(
                fileName: "RL_C_MAKER\\cm.str",
                attachedToTarget: true
            ),
            .wav(soundName: "effect\\RL_C_MARKER.wav"),
        ],
        "ef_em_activity_burn": [
            .str(
                fileName: "activity_burn\\activity_burn\\activity_burn.str",
                soundName: "effect\\em_activity_burn.wav",
                attachedToTarget: false
            ),
        ],
        "ef_em_activity_burn_cast": [
            .str(
                fileName: "activity_burn\\activity_burn_cast\\activity_burn_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "activity_burn\\activity_burn_cast_bottom\\activity_burn_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_conflagration": [
            .str(
                fileName: "conflagration\\conflagration.str",
                soundName: "effect\\em_conflagration.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "conflagration\\conflagration_bottom\\conflagration_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_conflagration_cast": [
            .str(
                fileName: "conflagration\\conflagration_cast\\conflagration_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "conflagration\\conflagration_cast_bottom\\conflagration_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_conflagration_hit": [
            .str(
                fileName: "conflagration\\conflagration_hit\\conflagration_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_diamond_storm": [
            .str(
                fileName: "diamond_storm\\diamond_storm\\diamond_storm.str",
                soundName: "effect\\em_diamond_storm.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "diamond_storm\\diamond_storm_bottom\\diamond_storm_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_diamond_storm_cast": [
            .str(
                fileName: "diamond_storm\\diamond_storm_cast\\diamond_storm_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "diamond_storm\\diamond_storm_cast_bottom\\diamond_storm_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_diamond_storm_hit": [
            .str(
                fileName: "diamond_storm\\diamond_storm_hit\\diamond_storm_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_el_cold_force": [
            .str(
                fileName: "diluvio\\diluvio_cold_force\\diluvio_cold_force.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_el_deadly_poison": [
            .str(
                fileName: "deadlypoison\\deadlypoison.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_el_deep_poisoning": [
            .str(
                fileName: "serpens\\serpens_deep_poisoning\\serpens_deep_poisoning.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_el_earth_care": [
            .str(
                fileName: "terremotus\\terremotus_earth_care\\terremotus_earth_care.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_el_flamearmor": [
            .str(
                fileName: "ardor\\ardor_flamearmor\\ardor_flamearmor.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_el_flametechnic": [
            .str(
                fileName: "ardor\\ardor_flametechnic\\ardor_flametechnic.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_el_grace_breeze": [
            .str(
                fileName: "procella\\procella_grace_breeze\\procella_grace_breeze.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_elemental_buster_cast": [
            .str(
                fileName: "elemental_buster\\elemental_buster_cast\\elemental_buster_cast.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_elemental_buster_fire": [
            .str(
                fileName: "elemental_buster\\elemental_buster\\elemental_buster_fire\\elemental_buster_fire.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "elemental_buster\\elemental_buster\\elemental_buster_fire_bottom\\elemental_buster_fire_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_elemental_buster_fire_hit": [
            .str(
                fileName: "elemental_buster\\elemental_buster_hit\\elemental_buster_fire_hit\\elemental_buster_fire_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_elemental_buster_ground": [
            .str(
                fileName: "elemental_buster\\elemental_buster\\elemental_buster_land\\elemental_buster_land.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "elemental_buster\\elemental_buster\\elemental_buster_land_bottom\\elemental_buster_land_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_elemental_buster_ground_hit": [
            .str(
                fileName: "elemental_buster\\elemental_buster_hit\\elemental_buster_land_hit\\elemental_buster_land_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_elemental_buster_poison": [
            .str(
                fileName: "elemental_buster\\elemental_buster\\elemental_buster_poison\\elemental_buster_poison.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "elemental_buster\\elemental_buster\\elemental_buster_poison_bottom\\elemental_buster_poison_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_elemental_buster_poison_hit": [
            .str(
                fileName: "elemental_buster\\elemental_buster_hit\\elemental_buster_poison_hit\\elemental_buster_poison_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_elemental_buster_water": [
            .str(
                fileName: "elemental_buster\\elemental_buster\\elemental_buster_water\\elemental_buster_water.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "elemental_buster\\elemental_buster\\elemental_buster_water_bottom\\elemental_buster_water_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_elemental_buster_water_hit": [
            .str(
                fileName: "elemental_buster\\elemental_buster_hit\\elemental_buster_water_hit\\elemental_buster_water_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_elemental_buster_wind": [
            .str(
                fileName: "elemental_buster\\elemental_buster\\elemental_buster_wind\\elemental_buster_wind.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "elemental_buster\\elemental_buster\\elemental_buster_wind_bottom\\elemental_buster_wind_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_elemental_buster_wind_hit": [
            .str(
                fileName: "elemental_buster\\elemental_buster_hit\\elemental_buster_wind_hit\\elemental_buster_wind_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_increasing_activity": [
            .str(
                fileName: "increasing_activity\\increasing_activity\\increasing_activity.str",
                soundName: "effect\\em_increasing_activity.wav",
                attachedToTarget: false
            ),
        ],
        "ef_em_increasing_activity_cast": [
            .str(
                fileName: "increasing_activity\\increasing_activity_cast\\increasing_activity_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "increasing_activity\\increasing_activity_cast_bottom\\increasing_activity_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_lightning_land": [
            .str(
                fileName: "lightning_land\\lightning_land\\lightning_land.str",
                soundName: "effect\\em_lightning_land.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "lightning_land\\lightning_land_bottom\\lightning_land_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_lightning_land_cast": [
            .str(
                fileName: "lightning_land\\lightning_land_cast\\lightning_land_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "lightning_land\\lightning_land_cast_bottom\\lightning_land_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_lightning_land_hit": [
            .str(
                fileName: "lightning_land\\lightning_land_hit\\lightning_land_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_spell_enchanting": [
            .str(
                fileName: "spell_enchanting\\spell_enchanting\\spell_enchanting.str",
                soundName: "effect\\em_spell_enchanting.wav",
                attachedToTarget: false
            ),
        ],
        "ef_em_summon_elemental_ardor": [
            .str(
                fileName: "ardor\\ardor\\ardor.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "ardor\\ardor_bottom\\ardor_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_summon_elemental_ardor_cast": [
            .str(
                fileName: "ardor\\ardor_cast\\ardor_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "ardor\\ardor_cast_bottom\\ardor_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_summon_elemental_ardor_hit": [
            .str(
                fileName: "ardor\\ardor_hit\\ardor_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_summon_elemental_diluvio_cast": [
            .str(
                fileName: "diluvio\\diluvio_cast\\diluvio_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "diluvio\\diluvio_cast_bottom\\diluvio_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_summon_elemental_diluvio_hit": [
            .str(
                fileName: "diluvio\\diluvio_hit\\diluvio_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_summon_elemental_procella": [
            .str(
                fileName: "procella\\procella\\procella.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "procella\\procella_bottom\\procella_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_summon_elemental_procella_cast": [
            .str(
                fileName: "procella\\procella_cast\\procella_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "procella\\procella_cast_bottom\\procella_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_summon_elemental_procella_hit": [
            .str(
                fileName: "procella\\procella_hit\\procella_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_summon_elemental_serpens": [
            .str(
                fileName: "serpens\\serpens_bottom\\serpens_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_summon_elemental_serpens_cast": [
            .str(
                fileName: "serpens\\serpens_cast\\serpens_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "serpens\\serpens_cast_bottom\\serpens_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
    ]

    private static let named2: [String : [EffectDefinition]] = [
        "ef_em_summon_elemental_serpens_hit": [
            .str(
                fileName: "serpens\\serpens_hit\\serpens_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_summon_elemental_terremotus": [
            .str(
                fileName: "terremotus\\terremotus\\terremotus.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_summon_elemental_terremotus_cast": [
            .str(
                fileName: "terremotus\\terremotus_cast\\terremotus_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "terremotus\\terremotus_cast_bottom\\terremotus_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_summon_elemental_terremotus_hit": [
            .str(
                fileName: "terremotus\\terremotus_hit\\terremotus_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_terra_drive": [
            .str(
                fileName: "terradrive\\terradrive\\terradrive.str",
                soundName: "effect\\em_terra_drive.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "terradrive\\terradrive_bottom\\terradrive_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_terra_drive_cast": [
            .str(
                fileName: "terradrive\\terradrive_cast\\terradrive_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "terradrive\\terradrive_cast_bottom\\terradrive_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_terra_drive_hit": [
            .str(
                fileName: "terradrive\\terradrive_hit\\terradrive_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_venom_swamp": [
            .str(
                fileName: "venom_swamp\\venom_swamp_bottom\\venom_swamp_bottom.str",
                soundName: "effect\\em_venom_swamp.wav",
                attachedToTarget: false
            ),
        ],
        "ef_em_venom_swamp_cast": [
            .str(
                fileName: "venom_swamp\\venom_swamp_cast\\venom_swamp_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "venom_swamp\\venom_swamp_cast_bottom\\venom_swamp_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_em_venom_swamp_hit": [
            .str(
                fileName: "venom_swamp\\venom_swamp_hit\\venom_swamp_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_firebreath": [
            .wav(soundName: "effect\\ef_firewall.wav"),
        ],
        "ef_gn_cart_tornado": [
            .str(
                fileName: "new_cart_tornado\\new_cart_tornado\\new_cart_tornado.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_cart_tornado\\new_cart_tornado_bottom\\new_cart_tornado_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_gn_cartboost": [
            .str(
                fileName: "new_cartboost\\new_cartboost\\new_cartboost.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_cartboost\\new_cartboost_bottom\\new_cartboost_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_gn_cartcannon": [
            .str(
                fileName: "new_cart_cannon\\new_cart_cannon\\new_cart_cannon.str",
                attachedToTarget: false
            ),
        ],
        "ef_gn_cartcannon_cast": [
            .str(
                fileName: "new_cart_cannon\\new_cart_cannon_cast\\new_cart_cannon_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_cart_cannon\\new_cart_cannon_cast_bottom\\new_cart_cannon_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_gn_changematerial": [
            .str(
                fileName: "changematerial_fa.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "changematerial_su.str",
                attachedToTarget: false
            ),
        ],
        "ef_gn_mandragora": [
            .str(
                fileName: "new_mandragora\\new_mandragora\\new_mandragora.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_mandragora\\new_mandragora_bottom\\new_mandragora_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_gn_mandragora_cast": [
            .str(
                fileName: "new_mandragora\\new_mandragora_cast\\new_mandragora_cast.str",
                attachedToTarget: false
            ),
        ],
        "ef_gn_wallofthorn_cast": [
            .str(
                fileName: "new_wallofthorn\\new_wallofthorn_cast\\new_wallofthorn_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_wallofthorn\\new_wallofthorn_cast_bottom\\new_wallofthorn_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_greed_sound": [
            .wav(soundName: "effect\\ef_entry.wav"),
        ],
        "ef_gs_increasing": [
            .str(
                fileName: "increasing_activity\\increasing_activity\\increasing_activity.str",
                attachedToTarget: false
            ),
        ],
        "ef_gs_increasing_cast": [
            .str(
                fileName: "increasing_activity\\increasing_activity_cast\\increasing_activity_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "increasing_activity\\increasing_activity_cast_bottom\\increasing_activity_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_hn_breakinglimit": [
            .str(
                fileName: "hyper_novice\\hn_breakinglimit\\breakinglimit\\breakinglimit.str",
                soundName: "effect\\hyper_novice\\hn_breakinglimit.wav",
                attachedToTarget: false
            ),
        ],
        "ef_hn_doublebowlingbash": [
            .str(
                fileName: "hyper_novice\\hn_doublebowlingbash\\double_bowlingbash.str",
                soundName: "effect\\hyper_novice\\hn_double_bowlingbash.wav",
                attachedToTarget: false
            ),
        ],
        "ef_hn_hells_drive": [
            .str(
                fileName: "hyper_novice\\hn_hells_drive\\hells_drive_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_hn_jupitel_thunder_storm": [
            .str(
                fileName: "hyper_novice\\hn_jupitel_thunder_storm\\jupitel_thunder_storm_ball\\jupitel_thunder_storm_ball.str",
                attachedToTarget: false
            ),
        ],
        "ef_hn_mega_sonic_blow": [
            .str(
                fileName: "hyper_novice\\hn_mega_sonic_blow\\mega_sonic_blow.str",
                soundName: "effect\\hyper_novice\\hn_mega_sonic_blow.wav",
                attachedToTarget: false
            ),
        ],
        "ef_hn_meteor_storm_buster": [
            .str(
                fileName: "hyper_novice\\hn_meteor_storm_buster\\meteor_storm_buster.str",
                soundName: "effect\\hyper_novice\\hn_meteor_storm_buster.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "hyper_novice\\hn_meteor_storm_buster\\meteor_storm_buster_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_hn_napalm_vulcan_strike": [
            .str(
                fileName: "hyper_novice\\hn_napalm_vulcan_strike\\napalm_vulcan_strike.str",
                soundName: "effect\\hyper_novice\\hn_napalm_vulcan_strike.wav",
                attachedToTarget: false
            ),
        ],
        "ef_hn_rulebreak": [
            .str(
                fileName: "hyper_novice\\hn_rulebreak\\rulebreak\\rulebreak.str",
                soundName: "effect\\hyper_novice\\hn_rulebreak.wav",
                attachedToTarget: false
            ),
        ],
        "ef_hn_shield_chain_rush": [
            .str(
                fileName: "hyper_novice\\hn_shield_chain_rush\\shield_chain_rush.str",
                soundName: "effect\\hyper_novice\\hn_shield_chain_rush.wav",
                attachedToTarget: false
            ),
        ],
        "ef_hn_spiral_pierce_max": [
            .str(
                fileName: "hyper_novice\\hn_spiral_pierce_max\\spiral_pierce_max.str",
                soundName: "effect\\hyper_novice\\hn_spiral_pierce_max.wav",
                attachedToTarget: false
            ),
        ],
        "ef_jackfrost": [
            .wav(soundName: "effect\\wl_jackfrost.wav"),
        ],
        "ef_ko_jyumonjikiri": [
            .str(
                fileName: "jyumonjikiri.str",
                attachedToTarget: false
            ),
        ],
        "ef_ko_setsudan": [
            .str(
                fileName: "setsudan.str",
                attachedToTarget: false
            ),
        ],
        "ef_magicpower": [
            .wav(soundName: K2L("effect\\마법력 증폭.wav")),
        ],
        "ef_mt_a_machine": [
            .str(
                fileName: "new_a_machine\\new_a_machine\\new_a_machine.str",
                soundName: "effect\\mt_a_machine.wav",
                attachedToTarget: false
            ),
        ],
        "ef_mt_a_machine_cast": [
            .str(
                fileName: "new_a_machine\\new_a_machine_cast\\new_a_machine_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_a_machine\\new_a_machine_cast_bottom\\new_a_machine_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_mt_a_machine_hit": [
            .str(
                fileName: "new_a_machine\\new_a_machine_attack\\new_a_machine_attack.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_a_machine\\new_a_machine_hit\\new_a_machine_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_mt_axe_stomp": [
            .str(
                fileName: "new_axe_stomp\\new_axe_stomp\\new_axe_stomp.str",
                soundName: "effect\\mt_axe_stomp.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_axe_stomp\\new_axe_stomp_bottom\\new_axe_stomp_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_mt_axe_stomp_hit": [
            .str(
                fileName: "new_axe_stomp\\new_axe_stomp_hit\\new_axe_stomp_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_mt_d_machine": [
            .str(
                fileName: "new_d_machine\\new_d_machine\\new_d_machine.str",
                soundName: "effect\\mt_d_machine.wav",
                attachedToTarget: false
            ),
        ],
        "ef_mt_d_machine_cast": [
            .str(
                fileName: "new_d_machine\\new_d_machine_cast\\new_d_machine_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_d_machine\\new_d_machine_cast_bottom\\new_d_machine_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_mt_mighty_smash": [
            .str(
                fileName: "meister\\mighty_smash\\mighty_smash\\mighty_smash.str",
                soundName: "effect\\mt_mighty_smash.wav",
                attachedToTarget: false
            ),
        ],
        "ef_mt_rush_quake": [
            .str(
                fileName: "new_rush_quake\\new_rush_quake\\new_rush_quake.str",
                soundName: "effect\\mt_rush_quake.wav",
                attachedToTarget: false
            ),
        ],
        "ef_mt_rush_quake_hit": [
            .str(
                fileName: "new_rush_quake\\new_rush_quake_hit\\new_rush_quake_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_mt_spark_blaster": [
            .str(
                fileName: "meister\\spark_blaster\\spark_blaster\\spark_blaster.str",
                soundName: "effect\\mt_spark_blaster.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "meister\\spark_blaster\\spark_blaster_bottom\\spark_blaster_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_mt_summon_abr_battle_warior": [
            .wav(soundName: "effect\\mt_summon_abr_battle_warior.wav"),
        ],
        "ef_mt_summon_abr_dual_cannon": [
            .wav(soundName: "effect\\mt_summon_abr_dual_cannon.wav"),
        ],
        "ef_mt_summon_abr_infinity": [
            .str(
                fileName: "new_abr_infinity\\new_abr_infinity\\new_abr_infinity.str",
                soundName: "effect\\mt_summon_abr_infinity.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_abr_infinity\\new_abr_infinity_bottom\\new_abr_infinity_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_mt_summon_abr_infinity_cast": [
            .str(
                fileName: "new_abr_infinity\\new_abr_infinity_cast\\new_abr_infinity_cast.str",
                attachedToTarget: false
            ),
        ],
        "ef_mt_summon_abr_infinity_hit": [
            .str(
                fileName: "new_abr_infinity\\new_abr_infinity_hit\\new_abr_infinity_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_mt_triple_laser": [
            .str(
                fileName: "meister\\triple_laser\\triple_laser\\triple_laser.str",
                soundName: "effect\\mt_triple_laser.wav",
                attachedToTarget: false
            ),
        ],
        "ef_nc_armscannon_cast": [
            .str(
                fileName: "new_armscannon\\new_armscannon_cast\\new_armscannon_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_armscannon\\new_armscannon_cast_bottom\\new_armscannon_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_nc_axeboomerang": [
            .str(
                fileName: "new_axeboomerang\\new_axeboomerang\\new_axeboomerang.str",
                attachedToTarget: false
            ),
        ],
        "ef_nc_axeboomerang_cast": [
            .str(
                fileName: "new_axeboomerang\\new_axeboomerang_cast\\new_axeboomerang_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_axeboomerang\\new_axeboomerang_cast_bottom\\new_axeboomerang_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_nc_axeboomerang_hit": [
            .str(
                fileName: "new_axeboomerang\\new_axeboomerang_hit\\new_axeboomerang_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_nc_axetornado": [
            .str(
                fileName: "new_axetornado\\new_axetornado\\new_axetornado.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_axetornado\\new_axetornado_bottom\\new_axetornado_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_nc_repair": [
            .str(
                fileName: "repair weapon.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "repairweapon.str",
                attachedToTarget: false
            ),
        ],
        "ef_nc_vulcanarm": [
            .str(
                fileName: "new_vulcanarm\\new_vulcanarm\\new_vulcanarm.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_vulcanarm\\new_vulcanarm_bottom\\new_vulcanarm_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_nv_helpangel": [
            .str(
                fileName: "help_angel\\help_angel\\help_angel.str",
                soundName: "effect\\priest_sanctuary.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "help_angel\\help_angel_bottom\\help_angel_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_nw_auto_firing_launcher": [
            .str(
                fileName: "night_watch\\nw_auto_firing_launcher\\auto_firing_launcher\\auto_firing_launcher.str",
                soundName: "effect\\night_watch\\nw_auto_firing_launcher.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "night_watch\\nw_auto_firing_launcher\\auto_firing_launcher_bottom\\auto_firing_launcher_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_nw_basic_grenade": [
            .str(
                fileName: "night_watch\\nw_basic_grenade\\basic_grenade\\basic_grenade.str",
                soundName: "effect\\night_watch\\nw_basic_grenade.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "night_watch\\nw_basic_grenade\\basic_grenade_bottom\\basic_grenade_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_nw_grenade_fragment": [
            .str(
                fileName: "night_watch\\nw_grenade_fragment\\grenade_fragment_fire\\grenade_fragment_fire.str",
                attachedToTarget: false
            ),
        ],
        "ef_nw_grenades_dropping": [
            .str(
                fileName: "night_watch\\nw_grenades_dropping\\grenades_dropping\\grenades_dropping.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "night_watch\\nw_grenades_dropping\\grenades_dropping_bottom\\grenades_dropping_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_nw_hidden_card": [
            .str(
                fileName: "night_watch\\nw_hidden_card\\hidden_card\\hiddencard.str",
                soundName: "effect\\night_watch\\nw_hidden_card.wav",
                attachedToTarget: false
            ),
        ],
        "ef_nw_intensive_aim": [
            .str(
                fileName: "night_watch\\nw_intensive_aim\\intensive_aim_full\\intensiveaim_full.str",
                soundName: "effect\\night_watch\\nw_intensive_aim.wav",
                attachedToTarget: false
            ),
        ],
        "ef_nw_magazine_for_one": [
            .str(
                fileName: "night_watch\\nw_magazine_for_one\\magazine_for_one.str",
                soundName: "effect\\night_watch\\nw_magazine_for_one.wav",
                attachedToTarget: false
            ),
        ],
        "ef_nw_mission_bombard_hit": [
            .str(
                fileName: "night_watch\\nw_mission_bombard\\mission_bombard\\mission_bombard_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_nw_only_one_bullet": [
            .str(
                fileName: "night_watch\\nw_only_one_bullet\\only_one_bullet\\only_one_bullet.str",
                soundName: "effect\\night_watch\\nw_only_one_bullet.wav",
                attachedToTarget: false
            ),
        ],
    ]

    private static let named3: [String : [EffectDefinition]] = [
        "ef_nw_only_one_bullet_hit": [
            .str(
                fileName: "night_watch\\nw_only_one_bullet\\only_one_bullet_hit\\only_one_bullet_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_nw_spiral_shooting": [
            .str(
                fileName: "night_watch\\nw_spiral_shooting\\spiral_shooting.str",
                soundName: "effect\\night_watch\\nw_spiral_shooting.wav",
                attachedToTarget: false
            ),
        ],
        "ef_nw_the_vigilante_at_night": [
            .str(
                fileName: "night_watch\\nw_the_vigilante_at_night\\the_vigilante_at_night_bottom\\the_vigilante_at_night_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_nw_wild_fire": [
            .str(
                fileName: "night_watch\\nw_wild_fire\\wild_fire\\wild_fire.str",
                soundName: "effect\\night_watch\\nw_wild_fire.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "night_watch\\nw_wild_fire\\wild_fire_bottom\\wild_fire_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_rl_d_tail": [
            .str(
                fileName: "rl_d_tail\\dtdt.str",
                soundName: "effect\\rl_d_tail.wav",
                attachedToTarget: false
            ),
        ],
        "ef_rl_e_chain": [
            .str(
                fileName: "rl_e_chain\\eternal.str",
                attachedToTarget: false
            ),
        ],
        "ef_rl_fallen_angel": [
            .str(
                fileName: "rl_fallen_angel\\penne.str",
                attachedToTarget: false
            ),
        ],
        "ef_rl_fire_rain": [
            .str(
                fileName: "rl_fire_rain\\fire_rain.str",
                soundName: "effect\\rl_fire_rain.wav",
                attachedToTarget: false
            ),
        ],
        "ef_rl_firedance": [
            .str(
                fileName: "rl_fire_dance\\firedance.str",
                attachedToTarget: false
            ),
        ],
        "ef_rl_h_mine": [
            .str(
                fileName: "rl_h_mine\\mine.str",
                soundName: "effect\\rl_h_mine.wav",
                attachedToTarget: false
            ),
        ],
        "ef_rl_heat_barrel": [
            .str(
                fileName: "rl_heat_barrel\\htb.str",
                attachedToTarget: false
            ),
        ],
        "ef_rl_p_alter": [
            .str(
                fileName: "rl_p_alter\\platinum.str",
                attachedToTarget: false
            ),
        ],
        "ef_rl_slugshot": [
            .str(
                fileName: "rl_slugshot\\slug.str",
                soundName: "effect\\rl_slugshot.wav",
                attachedToTarget: false
            ),
        ],
        "ef_s_storm": [
            .str(
                fileName: "S_STORM.str",
                soundName: "effect\\RL_S_STORM.wav",
                attachedToTarget: true
            ),
        ],
        "ef_sa_instantdeath": [
            .str(
                fileName: "suicide.str",
                attachedToTarget: false
            ),
        ],
        "ef_sc_autoshadowspell": [
            .str(
                fileName: "new_autoshadowspell\\new_autoshadowspell\\new_autoshadowspell.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_autoshadowspell\\new_autoshadowspell_bottom\\new_autoshadowspell_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_sc_fatalmenace": [
            .str(
                fileName: "new_fatal_menace\\new_fatal_menace\\new_fatal_menace.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_fatal_menace\\new_fatal_menace_bottom\\new_fatal_menace_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_sc_fatalmenace_cast": [
            .str(
                fileName: "new_fatal_menace\\new_fatal_menace_cast\\new_fatal_menace_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_fatal_menace\\new_fatal_menace_cast_bottom\\new_fatal_menace_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_sc_reproduce": [
            .str(
                fileName: "new_reproduce\\new_reproduce\\new_reproduce.str",
                soundName: "effect\\reproduce.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_reproduce\\new_reproduce_bottom\\new_reproduce_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_sh_blessing_of_mystical_creatures": [
            .str(
                fileName: "spirit_handler\\sh_blessing_of_mystical_creatures\\blessing_of_mystical_creatures.str",
                soundName: "effect\\spirit_handler\\sh_blessing_of_mystical_creatures.wav",
                attachedToTarget: false
            ),
        ],
        "ef_sh_chul_ho_sonic_claw": [
            .str(
                fileName: "spirit_handler\\sh_chul_ho_sonic_claw\\chul_ho_sonic_claw\\chul_ho_sonic_claw.str",
                soundName: "effect\\spirit_handler\\sh_chul_ho_sonic_claw.wav",
                attachedToTarget: false
            ),
        ],
        "ef_sh_colors_of_hyun_rok": [
            .str(
                fileName: "spirit_handler\\sh_colors_of_hyun_rok\\colors_of_hyun_rok_fire\\colors_of_hyun_rok_fire.str",
                soundName: "effect\\spirit_handler\\sh_colors_of_hyun_rok.wav",
                attachedToTarget: false
            ),
        ],
        "ef_sh_hogogong_strike": [
            .str(
                fileName: "spirit_handler\\sh_hogogong_strike\\hogogong_strike.str",
                soundName: "effect\\spirit_handler\\sh_hogogong_strike.wav",
                attachedToTarget: false
            ),
        ],
        "ef_sh_howling_of_chul_ho": [
            .str(
                fileName: "spirit_handler\\sh_howling_of_chul_ho\\howling_of_chul_ho\\howling_of_chul_ho.str",
                soundName: "effect\\spirit_handler\\sh_howling_of_chul_ho.wav",
                attachedToTarget: false
            ),
        ],
        "ef_sh_hyun_rok_cannon": [
            .str(
                fileName: "spirit_handler\\skid_sh_hyun_rok_cannon\\hyun_rok_cannon.str",
                soundName: "effect\\spirit_handler\\sh_hyun_rok_cannon.wav",
                attachedToTarget: false
            ),
        ],
        "ef_sh_ki_sul_rampage": [
            .str(
                fileName: "spirit_handler\\sh_ki_sul_rampage\\ki_sul_rampage\\ki_sul_rampage.str",
                soundName: "effect\\spirit_handler\\sh_ki_sul_rampage.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "spirit_handler\\sh_ki_sul_rampage\\ki_sul_rampage_bottom\\ki_sul_rampage_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_sh_ki_sul_water_spraying": [
            .str(
                fileName: "spirit_handler\\sh_ki_sul_water_spraying\\ki_sul_water_spraying.str",
                soundName: "effect\\spirit_handler\\sh_ki_sul_water_spraying.wav",
                attachedToTarget: false
            ),
        ],
        "ef_sh_marine_festival_of_ki_sul": [
            .str(
                fileName: "spirit_handler\\sh_marine_festival_of_ki_sul\\marine_festival_of_ki_sul\\marine_festival_of_ki_sul.str",
                soundName: "effect\\spirit_handler\\sh_marine_festival_of_ki_sul.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "spirit_handler\\sh_marine_festival_of_ki_sul\\marine_festival_of_ki_sul_bottom\\marine_festival_of_ki_sul_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_sh_sandy_festival_of_ki_sul": [
            .str(
                fileName: "spirit_handler\\sh_sandy_festival_of_ki_sul\\sandy_festival_of_ki_sul\\sandy_festival_of_ki_sul.str",
                soundName: "effect\\spirit_handler\\sh_sandy_festival_of_ki_sul.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "spirit_handler\\sh_sandy_festival_of_ki_sul\\sandy_festival_of_ki_sul_bottom\\sandy_festival_of_ki_sul_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_sh_temporary_communion": [
            .str(
                fileName: "spirit_handler\\sh_temporary_communion\\temporary_communion\\temporary_communion.str",
                soundName: "effect\\spirit_handler\\sh_temporary_communion.wav",
                attachedToTarget: false
            ),
        ],
        "ef_siennaexecrate": [
            .wav(soundName: "effect\\wl_siennaexecrate.wav"),
        ],
        "ef_sj_document": [
            .str(
                fileName: "sj_document\\sj_document.str",
                attachedToTarget: false
            ),
        ],
        "ef_sj_fallingstar": [
            .str(
                fileName: "falling_star\\falling_star.str",
                attachedToTarget: false
            ),
        ],
        "ef_sj_flashkick": [
            .str(
                fileName: "flash_kick\\flash_kick.str",
                attachedToTarget: false
            ),
        ],
        "ef_sj_fullmoonkick": [
            .str(
                fileName: "fullmoon_kick\\fullmoon_kick.str",
                attachedToTarget: false
            ),
        ],
        "ef_sj_newmoonkick": [
            .str(
                fileName: "newmoon_kick\\newmoon_kick.str",
                attachedToTarget: false
            ),
        ],
        "ef_sj_prominencekick": [
            .str(
                fileName: "prominence_kick\\prominence_kick.str",
                attachedToTarget: false
            ),
        ],
        "ef_sj_solarburst": [
            .str(
                fileName: "solar_burst\\solar_burst.str",
                attachedToTarget: false
            ),
        ],
        "ef_ske_all_in_the_sky": [
            .str(
                fileName: "sky_emperor\\ske_all_in_the_sky\\ske_all_in_the_sky.str",
                soundName: "effect\\sky_emperor\\ske_all_in_the_sky.wav",
                attachedToTarget: false
            ),
        ],
        "ef_ske_dawn_break": [
            .str(
                fileName: "sky_emperor\\ske_dawn_break\\ske_dawn_break.str",
                soundName: "effect\\sky_emperor\\ske_dawn_break.wav",
                attachedToTarget: false
            ),
        ],
        "ef_ske_enchanting_sky": [
            .wav(soundName: "effect\\sky_emperor\\ske_enchanting_sky.wav"),
        ],
        "ef_ske_midnight_kick": [
            .str(
                fileName: "sky_emperor\\ske_midnight_kick\\ske_midnight_kick.str",
                soundName: "effect\\sky_emperor\\ske_midnight_kick.wav",
                attachedToTarget: false
            ),
        ],
        "ef_ske_noon_blast": [
            .str(
                fileName: "sky_emperor\\ske_noon_blast\\ske_noon_blast.str",
                soundName: "effect\\sky_emperor\\ske_noon_blast.wav",
                attachedToTarget: false
            ),
        ],
        "ef_ske_rising_sun": [
            .str(
                fileName: "sky_emperor\\ske_rising_sun\\ske_rising_sun.str",
                attachedToTarget: false
            ),
        ],
        "ef_ske_star_burst": [
            .wav(soundName: "effect\\sky_emperor\\ske_star_burst.wav"),
        ],
        "ef_ske_star_cannon": [
            .str(
                fileName: "sky_emperor\\ske_star_cannon\\star_cannon\\ske_star_cannon.str",
                soundName: "effect\\sky_emperor\\ske_star_cannon.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "sky_emperor\\ske_star_cannon\\star_cannon_bottom\\ske_star_cannon_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ske_sunset_blast": [
            .str(
                fileName: "sky_emperor\\ske_sunset_blast\\sunset_blast.str",
                soundName: "effect\\sky_emperor\\ske_sunset_blast.wav",
                attachedToTarget: false
            ),
        ],
        "ef_ske_twinkling_galaxy": [
            .str(
                fileName: "sky_emperor\\ske_twinkling_galaxy\\twinkling_galaxy_bottom\\ske_twinkling_galaxy_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_sl_assasin": [
            .str(
                fileName: "assasin_poisonreact.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "assasin_poisonreact_1st.str",
                attachedToTarget: false
            ),
        ],
        "ef_sl_hunter": [
            .str(
                fileName: "hunter_loud.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "hunter_poison.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "hunter_shockwave_blue.str",
                attachedToTarget: false
            ),
        ],
        "ef_sl_stun": [
            .str(
                fileName: "stun.str",
                soundName: "effect\\_stun.wav",
                attachedToTarget: false
            ),
        ],
        "ef_so_diamonddust": [
            .str(
                fileName: "new_diamonddust\\new_diamonddust\\new_diamonddust.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_diamonddust\\new_diamonddust_bottom\\new_diamonddust_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_so_diamonddust_cast": [
            .str(
                fileName: "new_diamonddust\\new_diamonddust_cast\\new_diamonddust_cast.str",
                attachedToTarget: false
            ),
        ],
        "ef_so_earthgrave": [
            .str(
                fileName: "new_earthgrave\\new_earthgrave\\new_earthgrave.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_earthgrave\\new_earthgrave_bottom\\new_earthgrave_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_so_earthgrave_hit": [
            .str(
                fileName: "new_earthgrave\\new_earthgrave_hit\\new_earthgrave_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_so_el_cure": [
            .str(
                fileName: "cure.str",
                attachedToTarget: false
            ),
        ],
        "ef_so_poison_buster": [
            .str(
                fileName: "poison.str",
                attachedToTarget: false
            ),
        ],
        "ef_so_psychic_wave": [
            .str(
                fileName: "new_psychicwave\\new_psychicwave\\new_psychicwave.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_psychicwave\\new_psychicwave_bottom\\new_psychicwave_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_so_psychic_wave_cast": [
            .str(
                fileName: "new_psychicwave\\new_psychicwave_cast\\new_psychicwave_cast.str",
                attachedToTarget: false
            ),
        ],
        "ef_soa_circle_of_directions_and_elementals": [
            .str(
                fileName: "soul_ascetic\\soa_circle_of_directions_and_elementals\\circle_directions_elements\\circle_directions_elements.str",
                attachedToTarget: false
            ),
        ],
        "ef_soa_exorcism_of_malicious_soul": [
            .str(
                fileName: "soul_ascetic\\soa_exorcism_of_malicious_soul\\exorcism_of_malicuous_soul.str",
                attachedToTarget: false
            ),
        ],
        "ef_soa_soul_gathering": [
            .str(
                fileName: "soul_ascetic\\soa_soul_gathering\\soul_gathering.str",
                soundName: "effect\\soul_ascetic\\soa_soul_gathering.wav",
                attachedToTarget: false
            ),
        ],
        "ef_soa_soul_of_heaven_and_earth": [
            .str(
                fileName: "soul_ascetic\\soa_soul_of_heaven_and_earth\\soul_of_heaven_and_earth\\soul_of_heaven_and_earth.str",
                soundName: "effect\\soul_ascetic\\soa_soul_of_heaven_and_earth.wav",
                attachedToTarget: false
            ),
        ],
        "ef_soa_talisman_of_black_tortoise": [
            .str(
                fileName: "soul_ascetic\\soa_talisman_of_black_tortoise\\talisman_of_black_tortoise\\talisman_of_black_tortoise.str",
                soundName: "effect\\soul_ascetic\\soa_talisman_of_black_tortoise.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "soul_ascetic\\soa_talisman_of_black_tortoise\\talisman_of_black_tortoise_bottom\\talisman_of_black_tortoise_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_soa_talisman_of_blue_dragon": [
            .str(
                fileName: "soul_ascetic\\soa_talisman_of_blue_dragon\\talisman_of_blue_dragon.str",
                soundName: "effect\\soul_ascetic\\soa_talisman_of_blue_dragon.wav",
                attachedToTarget: false
            ),
        ],
        "ef_soa_talisman_of_five_elements": [
            .str(
                fileName: "soul_ascetic\\soa_talisman_of_five_elements\\talisman_of_the_five_elements.str",
                attachedToTarget: false
            ),
        ],
        "ef_soa_talisman_of_four_bearing_god": [
            .str(
                fileName: "soul_ascetic\\soa_talisman_of_four_bearing_god\\talisman_of_four_bearing_god.str",
                soundName: "effect\\soul_ascetic\\soa_talisman_of_four_bearing_god.wav",
                attachedToTarget: false
            ),
        ],
        "ef_soa_talisman_of_magician": [
            .str(
                fileName: "soul_ascetic\\soa_talisman_of_magician\\talisman_of_magician\\talisman_of_magician.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "soul_ascetic\\soa_talisman_of_magician\\talisman_of_magician_bottom\\talisman_of_magician_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_soa_talisman_of_protection": [
            .str(
                fileName: "soul_ascetic\\soa_talisman_of_protection\\talisman_of_protection.str",
                soundName: "effect\\soul_ascetic\\soa_talisman_of_protection.wav",
                attachedToTarget: false
            ),
        ],
        "ef_soa_talisman_of_red_phoenix": [
            .str(
                fileName: "soul_ascetic\\soa_talisman_of_red_phoenix\\talisman_of_red_phoenix\\talisman_of_red_phoenix.str",
                soundName: "effect\\soul_ascetic\\soa_talisman_of_red_phoenix.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "soul_ascetic\\soa_talisman_of_red_phoenix\\talisman_of_red_phoenix_bottom\\talisman_of_red_phoenix_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_soa_talisman_of_soul_stealing": [
            .str(
                fileName: "soul_ascetic\\soa_talisman_of_soul_stealing\\talisman_of_soul_stealing.str",
                soundName: "effect\\soul_ascetic\\soa_talisman_of_soul_stealing.wav",
                attachedToTarget: false
            ),
        ],
    ]

    private static let named4: [String : [EffectDefinition]] = [
        "ef_soa_talisman_of_warrior": [
            .str(
                fileName: "soul_ascetic\\soa_talisman_of_warrior\\talisman_of_warrior.str",
                soundName: "effect\\soul_ascetic\\soa_talisman_of_warrior.wav",
                attachedToTarget: false
            ),
        ],
        "ef_soa_talisman_of_white_tiger": [
            .str(
                fileName: "soul_ascetic\\soa_talisman_of_white_tiger\\talisman_of_white_tiger.str",
                soundName: "effect\\soul_ascetic\\soa_talisman_of_white_tiger.wav",
                attachedToTarget: false
            ),
        ],
        "ef_sp_soulcurse": [
            .str(
                fileName: "soul_curse\\soul_curse.str",
                attachedToTarget: false
            ),
        ],
        "ef_sp_soulgolem": [
            .str(
                fileName: "soul_golem\\soul_golem.str",
                attachedToTarget: false
            ),
        ],
        "ef_sp_soulrevolve": [
            .str(
                fileName: "soul_revolve\\soul_revolve.str",
                attachedToTarget: false
            ),
        ],
        "ef_ss_akumukesu": [
            .str(
                fileName: "shinkiro_shiranui\\ss_akumukesu\\akumukesu.str",
                soundName: "effect\\shinkiro_shiranui\\ss_akumukesu.wav",
                attachedToTarget: false
            ),
        ],
        "ef_ss_ankokuryuuakumu": [
            .wav(soundName: "effect\\shinkiro_shiranui\\ss_ankokuryuuakumu.wav"),
        ],
        "ef_ss_antenpou": [
            .str(
                fileName: "shinkiro_shiranui\\ss_antenpou\\antenpou.str",
                soundName: "effect\\shinkiro_shiranui\\ss_antenpou.wav",
                attachedToTarget: false
            ),
        ],
        "ef_ss_fuumakouchiku": [
            .str(
                fileName: "shinkiro_shiranui\\ss_fuumakouchiku\\fuumakouchiku\\fuumakouchiku.str",
                soundName: "effect\\shinkiro_shiranui\\ss_fuumakouchiku.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "shinkiro_shiranui\\ss_fuumakouchiku\\new_fuumakouchiku\\new_fuumakouchiku.str",
                attachedToTarget: false
            ),
        ],
        "ef_ss_fuumashouaku": [
            .str(
                fileName: "shinkiro_shiranui\\ss_fuumashouaku\\fuumashouaku\\fuumashouaku.str",
                soundName: "effect\\shinkiro_shiranui\\ss_fuumashouaku.wav",
                attachedToTarget: false
            ),
        ],
        "ef_ss_hitouakumu": [
            .str(
                fileName: "shinkiro_shiranui\\ss_hitouakumu\\hitouakumu\\hitouakumu.str",
                soundName: "effect\\shinkiro_shiranui\\ss_hitouakumu.wav",
                attachedToTarget: false
            ),
        ],
        "ef_ss_kageakumu": [
            .str(
                fileName: "shinkiro_shiranui\\ss_kageakumu\\kageakumu.str",
                attachedToTarget: false
            ),
        ],
        "ef_ss_kagegari": [
            .str(
                fileName: "shinkiro_shiranui\\ss_kagegari\\kagegari.str",
                soundName: "effect\\shinkiro_shiranui\\ss_kagegari.wav",
                attachedToTarget: false
            ),
        ],
        "ef_ss_kagegissen": [
            .str(
                fileName: "shinkiro_shiranui\\ss_kagegissen\\kagegissen.str",
                soundName: "effect\\shinkiro_shiranui\\ss_kagegissen.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "shinkiro_shiranui\\ss_kagegissen\\new_kagegissen\\new_kagegissen.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "shinkiro_shiranui\\ss_kagegissen\\new_kagegissen_bottom\\new_kagegissen_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ss_kagegissen_hit": [
            .str(
                fileName: "shinkiro_shiranui\\ss_kagegissen\\new_kagegissen_hit\\new_kagegissen_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_ss_kagenomai": [
            .str(
                fileName: "shinkiro_shiranui\\ss_kagenomai\\kagenomai.str",
                attachedToTarget: false
            ),
        ],
        "ef_ss_kinryuuhou": [
            .str(
                fileName: "shinkiro_shiranui\\ss_kinryuuhou\\kinryuuhou\\kinryuuhou.str",
                soundName: "effect\\shinkiro_shiranui\\ss_kinryuuhou.wav",
                attachedToTarget: false
            ),
        ],
        "ef_ss_kinryuuhou_hit": [
            .str(
                fileName: "shinkiro_shiranui\\ss_kinryuuhou\\kinryuuhou_hit\\kinryuuhou_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_ss_kunaikaiten": [
            .str(
                fileName: "shinkiro_shiranui\\ss_kunaikaiten\\kunaikaiten_bottom\\kunaikaiten_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ss_kunaikussetsu": [
            .str(
                fileName: "shinkiro_shiranui\\ss_kunaikussetsu\\kunaikussetsu\\kunaikussetsu.str",
                soundName: "effect\\shinkiro_shiranui\\ss_kunaikussetsu.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "shinkiro_shiranui\\ss_kunaikussetsu\\kunaikussetsu_bottom\\kunaikussetsu_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ss_kunaiwaikyoku": [
            .str(
                fileName: "shinkiro_shiranui\\ss_kunaiwaikyoku\\kunaiwaikyoku.str",
                soundName: "effect\\shinkiro_shiranui\\ss_kunaiwaikyoku.wav",
                attachedToTarget: false
            ),
        ],
        "ef_ss_raidenpou": [
            .str(
                fileName: "shinkiro_shiranui\\ss_raidenpou\\new_raidenpou\\new_raidenpou.str",
                soundName: "effect\\shinkiro_shiranui\\ss_raidenpou.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "shinkiro_shiranui\\ss_raidenpou\\raidenpou.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "shinkiro_shiranui\\ss_raidenpou\\new_raidenpou_bottom\\new_raidenpou_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ss_raidenpou_cast": [
            .str(
                fileName: "shinkiro_shiranui\\ss_raidenpou\\new_raidenpou_cast\\new_raidenpou_cast.str",
                soundName: "effect\\ef_beginspell.wav",
                attachedToTarget: true
            ),
        ],
        "ef_ss_raidenpou_hit": [
            .str(
                fileName: "shinkiro_shiranui\\ss_raidenpou\\new_raidenpou_hit\\new_raidenpou_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_ss_reiketsuhou": [
            .str(
                fileName: "shinkiro_shiranui\\ss_reiketsuhou\\reiketsuhou\\reiketsuhou.str",
                soundName: "effect\\shinkiro_shiranui\\ss_reiketsuhou.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "shinkiro_shiranui\\ss_reiketsuhou\\reiketsuhou_bottom\\reiketsuhou_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ss_sekienhou": [
            .str(
                fileName: "shinkiro_shiranui\\ss_sekienhou\\sekienhou.str",
                soundName: "effect\\shinkiro_shiranui\\ss_sekienhou.wav",
                attachedToTarget: false
            ),
        ],
        "ef_ss_shimiru": [
            .wav(soundName: "effect\\shinkiro_shiranui\\ss_shimiru.wav"),
        ],
        "ef_ss_tokedasu": [
            .str(
                fileName: "shinkiro_shiranui\\ss_tokedasu\\tokedasu\\tokedasu.str",
                soundName: "effect\\shinkiro_shiranui\\ss_tokedasu.wav",
                attachedToTarget: false
            ),
        ],
        "ef_su_arclousedash": [
            .str(
                fileName: "su_arclousedash\\su_arclousedash.str",
                attachedToTarget: false
            ),
        ],
        "ef_su_bite": [
            .str(
                fileName: "su_bite\\su_bite.str",
                attachedToTarget: false
            ),
        ],
        "ef_su_bunchofshrimp": [
            .str(
                fileName: "su_bunchofshrimp\\su_bunchofshrimp.str",
                attachedToTarget: false
            ),
        ],
        "ef_su_chattering": [
            .str(
                fileName: "su_chattering\\su_chattering.str",
                soundName: "effect\\su_chattering.wav",
                attachedToTarget: false
            ),
        ],
        "ef_su_freshshrimp": [
            .str(
                fileName: "su_freshshrimp\\su_freshshrimp.str",
                attachedToTarget: false
            ),
        ],
        "ef_su_grooming": [
            .str(
                fileName: "su_grooming\\su_grooming.str",
                soundName: "effect\\su_grooming.wav",
                attachedToTarget: false
            ),
        ],
        "ef_su_hiss": [
            .str(
                fileName: "su_hiss\\su_hiss.str",
                soundName: "effect\\su_hiss.wav",
                attachedToTarget: false
            ),
        ],
        "ef_su_nyanggrass": [
            .str(
                fileName: "su_nyanggrass\\su_nyanggrass.str",
                soundName: "effect\\su_nyanggrass.wav",
                attachedToTarget: false
            ),
        ],
        "ef_su_pickypeck": [
            .str(
                fileName: "su_pickypeck\\su_pickypeck.str",
                soundName: "effect\\su_pickypeck.wav",
                attachedToTarget: false
            ),
        ],
        "ef_su_powerofflock": [
            .str(
                fileName: "su_powerofflock\\su_powerofflock.str",
                soundName: "effect\\su_powerofflock.wav",
                attachedToTarget: false
            ),
        ],
        "ef_su_scaroftarou": [
            .str(
                fileName: "su_scaroftarou\\su_scaroftarou.str",
                soundName: "effect\\su_scaroftarou.wav",
                attachedToTarget: false
            ),
        ],
        "ef_su_scratch": [
            .str(
                fileName: "su_scratch\\su_scratch.str",
                soundName: "effect\\su_scratch.wav",
                attachedToTarget: false
            ),
        ],
        "ef_su_sv_stemspear": [
            .str(
                fileName: "su_sv_stemspear\\su_sv_stemspear.str",
                attachedToTarget: false
            ),
        ],
        "ef_su_svg_spirit": [
            .str(
                fileName: "su_svg_spirit\\su_svg_spirit.str",
                soundName: "effect\\su_svg_spirit.wav",
                attachedToTarget: false
            ),
        ],
        "ef_su_tunabelly": [
            .str(
                fileName: "su_tunabelly\\su_scratch.str",
                soundName: "effect\\su_tunabelly.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "su_tunabelly\\su_tunabelly.str",
                attachedToTarget: false
            ),
        ],
        "ef_thorntrap": [
            .wav(soundName: K2L("effect\\가시나무덫.wav")),
        ],
        "ef_tk_counter": [
            .str(
                fileName: "new_counter_slash\\new_counter_slash\\new_counter_slash.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_counter_slash\\new_counter_slash_bottom\\new_counter_slash_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_tomahawk_projectile": [
            .`3D`(
                kind: .texture(K2L("effect\\토마.bmp")),
                duration: 0.14,
                attachedToTarget: true,
                zIndex: 1,
                fadesIn: true,
                fadesOut: true,
                zOffsetStart: 1,
                zOffsetEnd: 1,
                movesToSource: true,
                size: [50, 50],
                angle: 180,
                rotates: true,
                rotationCount: 1,
                rotatesToTarget: true,
                rotatesWithCamera: true
            ),
        ],
        "ef_wl_chainlightning_cast": [
            .str(
                fileName: "new_chainlightning\\new_chainlightning_cast\\new_chainlightning_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_chainlightning\\new_chainlightning_cast_bottom\\new_chainlightning_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_wl_comet": [
            .str(
                fileName: "new_comet\\new_comet\\new_comet.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_comet\\new_comet_bottom\\new_comet_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_wl_comet_cast": [
            .str(
                fileName: "new_comet\\new_comet_cast\\new_comet_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_comet\\new_comet_cast_bottom\\new_comet_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_wl_hellinferno": [
            .str(
                fileName: "new_hellinferno\\new_hellinferno\\new_hellinferno.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_hellinferno\\new_hellinferno_bottom\\new_hellinferno_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_wl_hellinferno_cast": [
            .str(
                fileName: "new_hellinferno\\new_hellinferno_cast_bottom\\new_hellinferno_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_wl_soulexpansion_cast": [
            .str(
                fileName: "new_soulexpansion\\new_soulexpansion_cast\\new_soulexpansion_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_soulexpansion\\new_soulexpansion_cast_bottom\\new_soulexpansion_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_wl_soulexpansion_hit": [
            .str(
                fileName: "new_soulexpansion\\new_soulexpansion_hit\\new_soulexpansion_hit.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_soulexpansion\\new_soulexpansion_hit_bottom\\new_soulexpansion_hit_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_wl_summon_atk_fire": [
            .str(
                fileName: "fire.str",
                attachedToTarget: false
            ),
        ],
        "ef_wl_tetravortex_fire": [
            .str(
                fileName: "mineffect\\new_tetravortex\\new_tetravortex_fire\\new_tetravortex_fire.str",
                attachedToTarget: false
            ),
        ],
        "ef_wl_tetravortex_water": [
            .str(
                fileName: "mineffect\\new_tetravortex\\new_tetravortex_water\\new_tetravortex_water.str",
                attachedToTarget: false
            ),
        ],
        "ef_wl_tetravortex_wind": [
            .str(
                fileName: "mineffect\\new_tetravortex\\new_tetravortex_wind\\new_tetravortex_wind.str",
                attachedToTarget: false
            ),
        ],
        "gunslinger_coin": [
            .wav(soundName: K2L("effect\\플립.wav")),
        ],
        "stonecurse_sound": [
            .wav(soundName: "_stonecurse.wav"),
        ],
    ]
}
