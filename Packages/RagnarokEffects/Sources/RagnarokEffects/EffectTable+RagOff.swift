//
//  EffectTable+RagOff.swift
//  RagnarokEffects
//
//  [RagOff iPad Mod] Extra effects for Swordman, Archer, Acolyte and Thief skills.
//  Converted automatically from roBrowserLegacy EffectTable.js
//  (https://github.com/MrAntares/roBrowserLegacy/blob/master/src/DB/Effects/EffectTable.js).
//  Split into small dictionaries so each one type-checks quickly.
//

import Foundation
import RagnarokConstants
import RagnarokCore

enum RagOffEffectTable {
    static let idTable: [EffectID : [EffectDefinition]] = {
        var table: [EffectID : [EffectDefinition]] = [:]
        for chunk in [ids0, ids1, ids2, ids3, ids4] {
            table.merge(chunk) { first, _ in first }
        }
        return table
    }()

    static let namedTable: [String : [EffectDefinition]] = {
        var table: [String : [EffectDefinition]] = [:]
        for chunk in [named0, named1, named2, named3, named4, named5, named6, named7] {
            table.merge(chunk) { first, _ in first }
        }
        return table
    }()

    private static let ids0: [EffectID : [EffectDefinition]] = [
        .ef_ab_offertorium: [
            .str(
                fileName: "ab_offertorium.str",
                soundName: "effect\\ab_offertorium.wav",
                attachedToTarget: true
            ),
        ],
        .ef_absorbspirits: [
            .cylinder(
                textureName: "ring_blue.tga",
                soundName: K2L("effect\\흡기.wav"),
                duration: 1.5,
                attachedToTarget: true,
                blendMode: .one,
                color: [0.3, 0.3, 1],
                alpha: 0.3,
                fades: true,
                topRadius: 1.1,
                bottomRadius: 1.1,
                height: 15,
                animation: .growHeight,
                rotatesContinuously: true
            ),
            .cylinder(
                textureName: "ring_blue.tga",
                duration: 1.5,
                attachedToTarget: true,
                blendMode: .one,
                color: [0.3, 0.3, 1],
                alpha: 0.3,
                fades: true,
                topRadius: 1,
                bottomRadius: 1,
                height: 13,
                animation: .growHeight,
                rotatesContinuously: true
            ),
            .cylinder(
                textureName: "ring_blue.tga",
                duration: 1.5,
                attachedToTarget: true,
                blendMode: .one,
                color: [0.3, 0.3, 1],
                alpha: 0.3,
                fades: true,
                topRadius: 3,
                bottomRadius: 1.1,
                height: 2,
                animation: .growHeight,
                rotatesContinuously: true
            ),
            .`3D`(
                kind: .texture("effect\\pok3.tga"),
                duration: 1.5,
                duplicate: EffectParameters.Duplicate(count: 4, interval: 0.01),
                attachedToTarget: true,
                zIndex: 1,
                blendMode: .one,
                color: [0.3, 0.3, 1],
                alphaMax: 0.8,
                fadesIn: true,
                fadesOut: true,
                sparkles: true,
                sparkleCount: 2,
                positionXRandomRange: -1.2...1.2,
                positionYRandomRange: -1.2...1.2,
                positionEndZRandomRange: 7...9,
                size: [9, 9],
                sizeRandomRange: 7...11
            ),
            .`3D`(
                kind: .texture("effect\\pok3.tga"),
                duration: 1.3,
                delayOffset: 0.4,
                duplicate: EffectParameters.Duplicate(count: 20, interval: 0.01),
                attachedToTarget: true,
                zIndex: 1,
                blendMode: .one,
                color: [0.3, 0.3, 1],
                alphaMax: 0.8,
                fadesIn: true,
                fadesOut: true,
                sparkles: true,
                sparkleCount: 2,
                positionXRandomRange: -1.5...1.5,
                positionYRandomRange: -1.5...1.5,
                positionEndZRandomRange: 3...9,
                size: [9, 9],
                sizeRandomRange: 7...11
            ),
            .`3D`(
                kind: .texture("effect\\pok3.tga"),
                duration: 1.1,
                delayLate: 0.2,
                duplicate: EffectParameters.Duplicate(count: 10, interval: 0.05),
                attachedToTarget: true,
                zIndex: 1,
                blendMode: .one,
                color: [0.3, 0.3, 1],
                alphaMax: 0.8,
                fadesIn: true,
                fadesOut: true,
                positionEnd: [0, 0, 6],
                positionXRandomRange: -1...1,
                positionYRandomRange: -1...1,
                positionStartZRandomRange: -1...1,
                size: [9, 9],
                sizeRandomRange: 7...11
            ),
        ],
        .ef_ado_str: [
            .str(
                fileName: "ado.str",
                soundName: "effect\\ab_adoramus.wav",
                attachedToTarget: true
            ),
        ],
        .ef_aimed_str: [
            .str(
                fileName: "aimed.str",
                attachedToTarget: true
            ),
        ],
        .ef_arrowstorm_str: [
            .str(
                fileName: "arrowstorm.str",
                attachedToTarget: true
            ),
        ],
        .ef_aspersio: [
            .str(
                fileName: "aspersio.str",
                soundName: "effect\\priest_aspersio.wav",
                attachedToTarget: true
            ),
        ],
        .ef_assumptio2: [
            .str(
                fileName: "asum.str",
                soundName: K2L("effect\\아숨프티오.wav"),
                attachedToTarget: true
            ),
        ],
        .ef_aurablade: [
            .wav(soundName: K2L("effect\\오라 블레이드.wav")),
        ],
        .ef_bash3d: [
            .cylinder(
                textureName: "alpha_center.tga",
                duration: 0.175,
                delayStart: 0.2,
                duplicate: EffectParameters.Duplicate(count: 5, interval: 0),
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
                delayStart: 0.2,
                duplicate: EffectParameters.Duplicate(count: 5, interval: 0),
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
        .ef_bash3d2: [
            .cylinder(
                textureName: "alpha_center.tga",
                duration: 0.175,
                delayStart: 0.05,
                duplicate: EffectParameters.Duplicate(count: 8, interval: 0),
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
                delayStart: 0.05,
                duplicate: EffectParameters.Duplicate(count: 8, interval: 0),
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
        .ef_bash3d3: [
            .cylinder(
                textureName: "alpha_center.tga",
                duration: 0.175,
                delayStart: 0.5,
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
                delayStart: 0.5,
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
        .ef_bash3d4: [
            .cylinder(
                textureName: "alpha_center.tga",
                duration: 0.175,
                delayStart: 0.5,
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
                delayStart: 0.5,
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
        .ef_benedictio: [
            .str(
                fileName: "benedictio.str",
                soundName: "effect\\priest_benedictio.wav",
                attachedToTarget: true
            ),
        ],
        .ef_blastminebomb: [
            .str(
                fileName: "blastmine.str",
                soundName: "effect\\hunter_blastmine.wav",
                attachedToTarget: false
            ),
        ],
        .ef_blitzbeat: [
            .wav(soundName: "effect\\hunter_blitzbeat.wav"),
        ],
        .ef_bot_reverb: [
            .`3D`(
                kind: .texture("effect\\melody_b.bmp"),
                duration: 0.1,
                repeats: true,
                attachedToTarget: true,
                color: [1, 0.6, 0.6],
                alphaMax: 0.6,
                offset: [0, 0, 0.5],
                size: [50, 50]
            ),
            .wav(soundName: "effect\\reverberation.wav"),
        ],
        .ef_bot_reverb2: [
            .`3D`(
                kind: .texture("effect\\melody_a.bmp"),
                duration: 0.1,
                repeats: true,
                attachedToTarget: true,
                color: [0.6, 0.6, 1],
                alphaMax: 0.6,
                offset: [0, 0, 0.5],
                size: [50, 50]
            ),
            .wav(soundName: K2L("effect\\나락의노래.wav")),
        ],
        .ef_bottom_appleidun: [
            .wav(soundName: K2L("effect\\이둔의 사과.wav")),
        ],
        .ef_bottom_assassincross: [
            .wav(soundName: K2L("effect\\석양의 어쌔신.wav")),
        ],
        .ef_bottom_dontforgetme: [
            .wav(soundName: K2L("effect\\나를잊지말아요.wav")),
        ],
        .ef_bottom_drumbattlefield: [
            .wav(soundName: K2L("effect\\전장의.wav")),
        ],
        .ef_bottom_eternalchaos: [
            .wav(soundName: K2L("effect\\영원의 혼돈.wav")),
        ],
        .ef_bottom_fortunekiss: [
            .wav(soundName: K2L("effect\\행운의.wav")),
        ],
        .ef_bottom_gospel: [
            .wav(soundName: K2L("effect\\가스펠.wav")),
        ],
        .ef_bottom_humming: [
            .wav(soundName: K2L("effect\\흥얼거림.wav")),
        ],
        .ef_bottom_intoabyss: [
            .wav(soundName: K2L("effect\\심연속으로.wav")),
        ],
        .ef_bottom_lullaby: [
            .wav(soundName: K2L("effect\\자장가.wav")),
        ],
        .ef_bottom_mag: [
            .cylinder(
                textureName: "ring_red.tga",
                duration: 50,
                attachedToTarget: true,
                blendMode: .one,
                alpha: 0.2,
                topRadius: 0.7,
                bottomRadius: 0.7,
                height: 5,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                rotationDegrees: [0, 45, 0]
            ),
            .cylinder(
                textureName: "ring_red.tga",
                duration: 2,
                repeats: true,
                attachedToTarget: true,
                blendMode: .one,
                alpha: 0.1,
                fades: true,
                topRadius: 0.7,
                bottomRadius: 0.7,
                height: 5,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                animation: .growHeight,
                rotationDegrees: [0, 45, 0]
            ),
        ],
        .ef_bottom_poembragi: [
            .wav(soundName: K2L("effect\\브라기의 시.wav")),
        ],
        .ef_bottom_richmankim: [
            .wav(soundName: K2L("effect\\김서방돈.wav")),
        ],
    ]

    private static let ids1: [EffectID : [EffectDefinition]] = [
        .ef_bottom_ringnibelungen: [
            .wav(soundName: K2L("effect\\니벨룽겐의 반지.wav")),
        ],
        .ef_bottom_rokisweil: [
            .wav(soundName: K2L("effect\\로키.wav")),
        ],
        .ef_bottom_sanc: [
            .cylinder(
                textureName: "magic_green.tga",
                duration: 50,
                attachedToTarget: true,
                blendMode: .one,
                color: [0.5, 0.9, 0.5],
                alpha: 0.3,
                topRadius: 0.7,
                bottomRadius: 0.7,
                height: 2,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                rotationDegrees: [0, 45, 0]
            ),
            .cylinder(
                textureName: "magic_green.tga",
                duration: 2,
                repeats: true,
                attachedToTarget: true,
                blendMode: .one,
                color: [0.5, 0.9, 0.5],
                alpha: 0.1,
                fades: true,
                topRadius: 0.7,
                bottomRadius: 0.7,
                height: 2,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                animation: .growHeight,
                rotationDegrees: [0, 45, 0]
            ),
        ],
        .ef_bottom_serviceforyou: [
            .wav(soundName: K2L("effect\\당신을 위한 서비스.wav")),
        ],
        .ef_bottom_siegfried: [
            .wav(soundName: K2L("effect\\불사신.wav")),
        ],
        .ef_bottom_whistle: [
            .wav(soundName: K2L("effect\\달빛세레나데.wav")),
        ],
        .ef_bowlingself: [
            .str(
                fileName: "bowling.str",
                soundName: "_enemy_hit_normal1.wav",
                attachedToTarget: true
            ),
        ],
        .ef_brandish2: [
            .str(
                fileName: "brandish2.str",
                soundName: "effect\\knight_brandish_spear.wav",
                attachedToTarget: true
            ),
        ],
        .ef_brandishspear: [
            .str(
                fileName: "brandish.str",
                soundName: "effect\\knight_brandish_spear.wav",
                attachedToTarget: false
            ),
        ],
        .ef_chaincombo: [
            .str(
                fileName: K2L("연환.str"),
                soundName: K2L("effect\\mon_연환.wav"),
                attachedToTarget: true
            ),
        ],
        .ef_chemical_v2: [
            .wav(soundName: K2L("effect\\안식의자장가.wav")),
        ],
        .ef_chemicalprotection: [
            .wav(soundName: "apocalips_attack.wav"),
        ],
        .ef_chimto: [
            .wav(soundName: K2L("effect\\mon_침투경.wav")),
        ],
        .ef_circlepower2: [
            .wav(soundName: K2L("effect\\순환하는자연의소리.wav")),
        ],
        .ef_claymore: [
            .str(
                fileName: "claymore.str",
                soundName: "effect\\hunter_claymoretrap.wav",
                attachedToTarget: false
            ),
        ],
        .ef_concentration2: [
            .str(
                fileName: "concentration.str",
                attachedToTarget: true
            ),
        ],
        .ef_dance1: [
            .wav(soundName: K2L("effect\\수줍은하루의우울.wav")),
        ],
        .ef_defender: [
            .cylinder(
                textureName: "ring_black.tga",
                duration: 3,
                attachedToTarget: true,
                blendMode: .oneMinusSourceAlpha,
                alpha: 0.6,
                fades: true,
                topRadius: 1.5,
                bottomRadius: 1.5,
                height: 10,
                animation: .growHeight,
                rotatesContinuously: true
            ),
        ],
        .ef_detecting: [
            .wav(soundName: "effect\\hunter_detecting.wav"),
        ],
        .ef_detoxication: [
            .`3D`(
                kind: .texture("effect\\pok1.tga"),
                duration: 1,
                duplicate: EffectParameters.Duplicate(count: 10, interval: 0.2),
                attachedToTarget: true,
                zIndex: 1,
                color: [0.7, 1, 1],
                alphaMax: 1,
                fadesIn: true,
                fadesOut: true,
                positionEnd: [0, 0, 5],
                positionXRandomRange: -1...1,
                positionYRandomRange: -1...1,
                sizeRandomRange: 80...120
            ),
            .wav(soundName: "effect\\ef_detoxication.wav"),
        ],
        .ef_devotion: [
            .str(
                fileName: "devotion.str",
                attachedToTarget: true
            ),
        ],
        .ef_dhowl_str: [
            .str(
                fileName: "dragon_h.str",
                soundName: "dragon_h.wav",
                attachedToTarget: true
            ),
        ],
        .ef_earthhit: [
            .str(
                fileName: "earthhit.str",
                attachedToTarget: true
            ),
        ],
        .ef_electric4: [
            .wav(soundName: "effect\\sr_earthshaker.wav"),
        ],
        .ef_falconassault: [
            .wav(soundName: "effect\\hunter_blitzbeat.wav"),
        ],
        .ef_firepillaron2: [
            .wav(soundName: "effect\\ab_judex.wav"),
            .cylinder(
                textureName: "ring_white.tga",
                duration: 1,
                attachedToTarget: false,
                topRadius: 0.5,
                bottomRadius: 0.4,
                height: 3.5,
                rotatesContinuously: true
            ),
            .cylinder(
                textureName: "ring_white.tga",
                duration: 1,
                attachedToTarget: false,
                topRadius: 0.75,
                bottomRadius: 0.45,
                height: 2.5,
                rotatesContinuously: true
            ),
            .cylinder(
                textureName: "ring_white.tga",
                duration: 1,
                attachedToTarget: false,
                topRadius: 1,
                bottomRadius: 0.5,
                height: 1.5,
                rotatesContinuously: true
            ),
        ],
        .ef_flasher: [
            .wav(soundName: "effect\\hunter_flasher.wav"),
        ],
        .ef_freezing: [
            .str(
                fileName: "freezing.str",
                soundName: "effect\\hunter_freezingtrap.wav",
                attachedToTarget: false
            ),
        ],
        .ef_fvoice: [
            .spr(
                fileName: "fvoice",
                soundName: "amon_ra_die01.wav",
                attachedToTarget: false
            ),
        ],
        .ef_glasswall3: [
            .cylinder(
                textureName: "magic_green.tga",
                duration: 0.5,
                duplicate: EffectParameters.Duplicate(count: 150, interval: 0.2),
                attachedToTarget: true,
                blendMode: .one,
                color: [0.6, 1, 0.6],
                alpha: 0.4,
                topRadius: 3.9,
                bottomRadius: 2.4,
                height: 0.1,
                animation: .growRadius,
                positionOffset: [0, 0, 0.1],
                rotatesContinuously: true
            ),
            .cylinder(
                textureName: "magic_green.tga",
                duration: 30,
                attachedToTarget: true,
                blendMode: .one,
                color: [0.6, 1, 0.6],
                alpha: 0.4,
                fades: true,
                topRadius: 0.6,
                bottomRadius: 0.6,
                height: 7,
                rotatesContinuously: true
            ),
            .cylinder(
                textureName: "magic_green.tga",
                duration: 30,
                attachedToTarget: true,
                blendMode: .one,
                color: [0.6, 1, 0.6],
                alpha: 0.4,
                fades: true,
                topRadius: 0.8,
                bottomRadius: 0.8,
                height: 6,
                rotatesContinuously: true
            ),
            .cylinder(
                textureName: "alpha1.tga",
                duration: 30,
                attachedToTarget: true,
                blendMode: .one,
                color: [0.6, 1, 0.6],
                alpha: 0.5,
                fades: true,
                topRadius: 1,
                bottomRadius: 1,
                height: 1,
                totalCircleSides: 20,
                visibleCircleSides: 10,
                textureRepeatX: 2,
                positionOffset: [0, 0, 2],
                rotatesContinuously: true
            ),
        ],
    ]

    private static let ids2: [EffectID : [EffectDefinition]] = [
        .ef_glasswall4: [
            .`3D`(
                kind: .texture("effect\\ef_epitree.tga"),
                soundName: "effect\\ef_readyportal.wav",
                duration: 30,
                attachedToTarget: true,
                zIndex: 1,
                blendMode: .one,
                color: [0.0001, 1, 0.0001],
                alphaMax: 0.6,
                offset: [0, 0, 7],
                size: [400, 400]
            ),
            .`3D`(
                kind: .texture("effect\\ef_epitree.tga"),
                duration: 0.99,
                duplicate: EffectParameters.Duplicate(count: 15, interval: 2),
                attachedToTarget: true,
                zIndex: 1,
                blendMode: .one,
                color: [0.0001, 1, 0.0001],
                alphaMax: 0.6,
                offset: [0, 0, 7],
                sizeStart: [380, 380],
                sizeEnd: [420, 420]
            ),
            .`3D`(
                kind: .texture("effect\\ef_epitree.tga"),
                duration: 0.99,
                delayOffset: 1,
                duplicate: EffectParameters.Duplicate(count: 15, interval: 2),
                attachedToTarget: true,
                zIndex: 1,
                blendMode: .one,
                color: [0.0001, 1, 0.0001],
                alphaMax: 0.6,
                offset: [0, 0, 7],
                sizeStart: [420, 420],
                sizeEnd: [380, 380]
            ),
        ],
        .ef_gloria: [
            .str(
                fileName: "gloria.str",
                soundName: "effect\\priest_gloria.wav",
                attachedToTarget: true
            ),
        ],
        .ef_grandcross: [
            .cylinder(
                textureName: "ring_red.tga",
                duration: 1,
                duplicate: EffectParameters.Duplicate(count: 3, interval: 0.5),
                attachedToTarget: false,
                blendMode: .one,
                alpha: 0.1,
                fades: true,
                topRadius: 0.7,
                bottomRadius: 0.7,
                height: 5,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                animation: .growHeight,
                rotationDegrees: [0, 45, 0]
            ),
            .cylinder(
                textureName: "ring_red.tga",
                duration: 1,
                duplicate: EffectParameters.Duplicate(count: 3, interval: 0.5),
                attachedToTarget: false,
                blendMode: .one,
                alpha: 0.1,
                fades: true,
                topRadius: 0.7,
                bottomRadius: 0.7,
                height: 5,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                animation: .growHeight,
                positionOffset: [-1, 0, 0],
                rotationDegrees: [0, 45, 0]
            ),
            .cylinder(
                textureName: "ring_red.tga",
                duration: 1,
                duplicate: EffectParameters.Duplicate(count: 3, interval: 0.5),
                attachedToTarget: false,
                blendMode: .one,
                alpha: 0.1,
                fades: true,
                topRadius: 0.7,
                bottomRadius: 0.7,
                height: 5,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                animation: .growHeight,
                positionOffset: [-2, 0, 0],
                rotationDegrees: [0, 45, 0]
            ),
            .cylinder(
                textureName: "ring_red.tga",
                duration: 1,
                duplicate: EffectParameters.Duplicate(count: 3, interval: 0.5),
                attachedToTarget: false,
                blendMode: .one,
                alpha: 0.1,
                fades: true,
                topRadius: 0.7,
                bottomRadius: 0.7,
                height: 5,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                animation: .growHeight,
                positionOffset: [-3, 0, 0],
                rotationDegrees: [0, 45, 0]
            ),
            .cylinder(
                textureName: "ring_red.tga",
                duration: 1,
                duplicate: EffectParameters.Duplicate(count: 3, interval: 0.5),
                attachedToTarget: false,
                blendMode: .one,
                alpha: 0.1,
                fades: true,
                topRadius: 0.7,
                bottomRadius: 0.7,
                height: 5,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                animation: .growHeight,
                positionOffset: [-4, 0, 0],
                rotationDegrees: [0, 45, 0]
            ),
            .cylinder(
                textureName: "ring_red.tga",
                duration: 1,
                duplicate: EffectParameters.Duplicate(count: 3, interval: 0.5),
                attachedToTarget: false,
                blendMode: .one,
                alpha: 0.1,
                fades: true,
                topRadius: 0.7,
                bottomRadius: 0.7,
                height: 5,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                animation: .growHeight,
                positionOffset: [1, 0, 0],
                rotationDegrees: [0, 45, 0]
            ),
            .cylinder(
                textureName: "ring_red.tga",
                duration: 1,
                duplicate: EffectParameters.Duplicate(count: 3, interval: 0.5),
                attachedToTarget: false,
                blendMode: .one,
                alpha: 0.1,
                fades: true,
                topRadius: 0.7,
                bottomRadius: 0.7,
                height: 5,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                animation: .growHeight,
                positionOffset: [2, 0, 0],
                rotationDegrees: [0, 45, 0]
            ),
            .cylinder(
                textureName: "ring_red.tga",
                duration: 1,
                duplicate: EffectParameters.Duplicate(count: 3, interval: 0.5),
                attachedToTarget: false,
                blendMode: .one,
                alpha: 0.1,
                fades: true,
                topRadius: 0.7,
                bottomRadius: 0.7,
                height: 5,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                animation: .growHeight,
                positionOffset: [3, 0, 0],
                rotationDegrees: [0, 45, 0]
            ),
            .cylinder(
                textureName: "ring_red.tga",
                duration: 1,
                duplicate: EffectParameters.Duplicate(count: 3, interval: 0.5),
                attachedToTarget: false,
                blendMode: .one,
                alpha: 0.1,
                fades: true,
                topRadius: 0.7,
                bottomRadius: 0.7,
                height: 5,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                animation: .growHeight,
                positionOffset: [4, 0, 0],
                rotationDegrees: [0, 45, 0]
            ),
            .cylinder(
                textureName: "ring_red.tga",
                duration: 1,
                duplicate: EffectParameters.Duplicate(count: 3, interval: 0.5),
                attachedToTarget: false,
                blendMode: .one,
                alpha: 0.1,
                fades: true,
                topRadius: 0.7,
                bottomRadius: 0.7,
                height: 5,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                animation: .growHeight,
                positionOffset: [0, 1, 0],
                rotationDegrees: [0, 45, 0]
            ),
            .cylinder(
                textureName: "ring_red.tga",
                duration: 1,
                duplicate: EffectParameters.Duplicate(count: 3, interval: 0.5),
                attachedToTarget: false,
                blendMode: .one,
                alpha: 0.1,
                fades: true,
                topRadius: 0.7,
                bottomRadius: 0.7,
                height: 5,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                animation: .growHeight,
                positionOffset: [0, 2, 0],
                rotationDegrees: [0, 45, 0]
            ),
            .cylinder(
                textureName: "ring_red.tga",
                duration: 1,
                duplicate: EffectParameters.Duplicate(count: 3, interval: 0.5),
                attachedToTarget: false,
                blendMode: .one,
                alpha: 0.1,
                fades: true,
                topRadius: 0.7,
                bottomRadius: 0.7,
                height: 5,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                animation: .growHeight,
                positionOffset: [0, 3, 0],
                rotationDegrees: [0, 45, 0]
            ),
            .cylinder(
                textureName: "ring_red.tga",
                duration: 1,
                duplicate: EffectParameters.Duplicate(count: 3, interval: 0.5),
                attachedToTarget: false,
                blendMode: .one,
                alpha: 0.1,
                fades: true,
                topRadius: 0.7,
                bottomRadius: 0.7,
                height: 5,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                animation: .growHeight,
                positionOffset: [0, 4, 0],
                rotationDegrees: [0, 45, 0]
            ),
            .cylinder(
                textureName: "ring_red.tga",
                duration: 1,
                duplicate: EffectParameters.Duplicate(count: 3, interval: 0.5),
                attachedToTarget: false,
                blendMode: .one,
                alpha: 0.1,
                fades: true,
                topRadius: 0.7,
                bottomRadius: 0.7,
                height: 5,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                animation: .growHeight,
                positionOffset: [0, -1, 0],
                rotationDegrees: [0, 45, 0]
            ),
            .cylinder(
                textureName: "ring_red.tga",
                duration: 1,
                duplicate: EffectParameters.Duplicate(count: 3, interval: 0.5),
                attachedToTarget: false,
                blendMode: .one,
                alpha: 0.1,
                fades: true,
                topRadius: 0.7,
                bottomRadius: 0.7,
                height: 5,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                animation: .growHeight,
                positionOffset: [0, -2, 0],
                rotationDegrees: [0, 45, 0]
            ),
            .cylinder(
                textureName: "ring_red.tga",
                duration: 1,
                duplicate: EffectParameters.Duplicate(count: 3, interval: 0.5),
                attachedToTarget: false,
                blendMode: .one,
                alpha: 0.1,
                fades: true,
                topRadius: 0.7,
                bottomRadius: 0.7,
                height: 5,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                animation: .growHeight,
                positionOffset: [0, -3, 0],
                rotationDegrees: [0, 45, 0]
            ),
            .cylinder(
                textureName: "ring_red.tga",
                duration: 1,
                duplicate: EffectParameters.Duplicate(count: 3, interval: 0.5),
                attachedToTarget: false,
                blendMode: .one,
                alpha: 0.1,
                fades: true,
                topRadius: 0.7,
                bottomRadius: 0.7,
                height: 5,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                animation: .growHeight,
                positionOffset: [0, -4, 0],
                rotationDegrees: [0, 45, 0]
            ),
            .cylinder(
                textureName: "ring_red.tga",
                duration: 1,
                duplicate: EffectParameters.Duplicate(count: 3, interval: 0.5),
                attachedToTarget: false,
                blendMode: .one,
                alpha: 0.1,
                fades: true,
                topRadius: 0.7,
                bottomRadius: 0.7,
                height: 5,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                animation: .growHeight,
                positionOffset: [1, 1, 0],
                rotationDegrees: [0, 45, 0]
            ),
            .cylinder(
                textureName: "ring_red.tga",
                duration: 1,
                duplicate: EffectParameters.Duplicate(count: 3, interval: 0.5),
                attachedToTarget: false,
                blendMode: .one,
                alpha: 0.1,
                fades: true,
                topRadius: 0.7,
                bottomRadius: 0.7,
                height: 5,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                animation: .growHeight,
                positionOffset: [1, -1, 0],
                rotationDegrees: [0, 45, 0]
            ),
            .cylinder(
                textureName: "ring_red.tga",
                duration: 1,
                duplicate: EffectParameters.Duplicate(count: 3, interval: 0.5),
                attachedToTarget: false,
                blendMode: .one,
                alpha: 0.1,
                fades: true,
                topRadius: 0.7,
                bottomRadius: 0.7,
                height: 5,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                animation: .growHeight,
                positionOffset: [-1, -1, 0],
                rotationDegrees: [0, 45, 0]
            ),
            .cylinder(
                textureName: "ring_red.tga",
                duration: 1,
                duplicate: EffectParameters.Duplicate(count: 3, interval: 0.5),
                attachedToTarget: false,
                blendMode: .one,
                alpha: 0.1,
                fades: true,
                topRadius: 0.7,
                bottomRadius: 0.7,
                height: 5,
                totalCircleSides: 4,
                visibleCircleSides: 4,
                animation: .growHeight,
                positionOffset: [-1, 1, 0],
                rotationDegrees: [0, 45, 0]
            ),
            .cylinder(
                textureName: "ring_red.tga",
                duration: 1,
                duplicate: EffectParameters.Duplicate(count: 3, interval: 0.5),
                attachedToTarget: false,
                blendMode: .one,
                alpha: 0.1,
                fades: true,
                topRadius: 3,
                bottomRadius: 3,
                height: 5,
                totalCircleSides: 20,
                visibleCircleSides: 5,
                animation: .growHeight,
                positionOffset: [3.5, 3.5, 0],
                rotationDegrees: [0, -180, 0]
            ),
            .cylinder(
                textureName: "ring_red.tga",
                duration: 1,
                duplicate: EffectParameters.Duplicate(count: 3, interval: 0.5),
                attachedToTarget: false,
                blendMode: .one,
                alpha: 0.1,
                fades: true,
                topRadius: 3,
                bottomRadius: 3,
                height: 5,
                totalCircleSides: 20,
                visibleCircleSides: 5,
                animation: .growHeight,
                positionOffset: [3.5, -3.5, 0],
                rotationDegrees: [0, 90, 0]
            ),
            .cylinder(
                textureName: "ring_red.tga",
                duration: 1,
                duplicate: EffectParameters.Duplicate(count: 3, interval: 0.5),
                attachedToTarget: false,
                blendMode: .one,
                alpha: 0.1,
                fades: true,
                topRadius: 3,
                bottomRadius: 3,
                height: 5,
                totalCircleSides: 20,
                visibleCircleSides: 5,
                animation: .growHeight,
                positionOffset: [-3.5, -3.5, 0]
            ),
            .cylinder(
                textureName: "ring_red.tga",
                duration: 1,
                duplicate: EffectParameters.Duplicate(count: 3, interval: 0.5),
                attachedToTarget: false,
                blendMode: .one,
                alpha: 0.1,
                fades: true,
                topRadius: 3,
                bottomRadius: 3,
                height: 5,
                totalCircleSides: 20,
                visibleCircleSides: 5,
                animation: .growHeight,
                positionOffset: [-3.5, 3.5, 0],
                rotationDegrees: [0, -90, 0]
            ),
            .wav(soundName: "effect\\cru_grand cross.wav"),
        ],
        .ef_grimtooth: [
            .wav(soundName: "effect\\ef_frostdiver.wav"),
        ],
        .ef_guard: [
            .wav(soundName: "effect\\kyrie_guard.wav"),
            .cylinder(
                textureName: "guardk.tga",
                duration: 0.6,
                attachedToTarget: true,
                blendMode: .one,
                color: [0.91, 1, 0.9],
                alpha: 0.6,
                fades: true,
                topRadius: 1,
                bottomRadius: 1.5,
                height: 0.7,
                totalCircleSides: 8,
                visibleCircleSides: 5,
                textureRepeatX: 5,
                positionOffset: [0, 0, 2.14],
                rotationDegrees: [0, 112.5, 0],
                rotatesWithSource: true
            ),
            .cylinder(
                textureName: "guardk.tga",
                duration: 0.6,
                attachedToTarget: true,
                blendMode: .one,
                color: [0.91, 1, 0.9],
                alpha: 0.6,
                fades: true,
                topRadius: 1.5,
                bottomRadius: 1.5,
                height: 1.14,
                totalCircleSides: 8,
                visibleCircleSides: 5,
                textureRepeatX: 5,
                positionOffset: [0, 0, 1],
                rotationDegrees: [0, 112.5, 0],
                rotatesWithSource: true
            ),
            .cylinder(
                textureName: "guardk.tga",
                duration: 0.6,
                attachedToTarget: true,
                blendMode: .one,
                color: [0.91, 1, 0.9],
                alpha: 0.6,
                fades: true,
                topRadius: 1.5,
                bottomRadius: 1,
                height: 0.7,
                totalCircleSides: 8,
                visibleCircleSides: 5,
                textureRepeatX: 5,
                positionOffset: [0, 0, 0.3],
                rotationDegrees: [0, 112.5, 0],
                rotatesWithSource: true
            ),
        ],
        .ef_gumgang2: [
            .cylinder(
                textureName: "ring_yellow.tga",
                duration: 1.5,
                duplicate: EffectParameters.Duplicate(count: 4, interval: 0.1),
                attachedToTarget: true,
                blendMode: .oneMinusSourceAlpha,
                alpha: 0.5,
                fades: true,
                topRadius: 5,
                bottomRadius: 2,
                height: 2,
                animation: .growRadius,
                rotatesContinuously: true
            ),
            .wav(soundName: K2L("effect\\mon_폭기.wav")),
        ],
        .ef_gumgang3: [
            .cylinder(
                textureName: "ring_yellow.tga",
                duration: 1,
                duplicate: EffectParameters.Duplicate(count: 4, interval: 0.1),
                attachedToTarget: true,
                blendMode: .oneMinusSourceAlpha,
                alpha: 0.3,
                fades: true,
                topRadius: 6,
                bottomRadius: 3,
                height: 2,
                animation: .growRadius,
                rotatesContinuously: true
            ),
        ],
        .ef_heal2: [
            .cylinder(
                textureName: "ring_white.tga",
                soundName: "_heal_effect.wav",
                duration: 1.5,
                attachedToTarget: true,
                blendMode: .one,
                color: [0.7, 1, 0.7],
                alpha: 0.3,
                fades: true,
                topRadius: 1.1,
                bottomRadius: 1.1,
                height: 15,
                animation: .growHeight,
                rotatesContinuously: true
            ),
            .cylinder(
                textureName: "ring_white.tga",
                soundName: "_heal_effect.wav",
                duration: 1.5,
                attachedToTarget: true,
                blendMode: .one,
                color: [0.7, 1, 0.7],
                alpha: 0.3,
                fades: true,
                topRadius: 1,
                bottomRadius: 1,
                height: 13,
                animation: .growHeight,
                rotatesContinuously: true
            ),
            .cylinder(
                textureName: "ring_white.tga",
                duration: 1.5,
                attachedToTarget: true,
                blendMode: .one,
                color: [0.7, 1, 0.7],
                alpha: 0.3,
                fades: true,
                topRadius: 3,
                bottomRadius: 1.1,
                height: 2,
                animation: .growHeight,
                rotatesContinuously: true
            ),
            .`3D`(
                kind: .texture("effect\\pok3.tga"),
                duration: 1.5,
                duplicate: EffectParameters.Duplicate(count: 4, interval: 0.01),
                attachedToTarget: true,
                zIndex: 1,
                blendMode: .one,
                alphaMax: 0.8,
                fadesIn: true,
                fadesOut: true,
                sparkles: true,
                sparkleCount: 2,
                positionXRandomRange: -1.2...1.2,
                positionYRandomRange: -1.2...1.2,
                positionEndZRandomRange: 7...9,
                size: [9, 9],
                sizeRandomRange: 7...11
            ),
            .`3D`(
                kind: .texture("effect\\pok3.tga"),
                duration: 1.3,
                delayOffset: 0.4,
                duplicate: EffectParameters.Duplicate(count: 20, interval: 0.01),
                attachedToTarget: true,
                zIndex: 1,
                blendMode: .one,
                alphaMax: 0.8,
                fadesIn: true,
                fadesOut: true,
                sparkles: true,
                sparkleCount: 2,
                positionXRandomRange: -1.5...1.5,
                positionYRandomRange: -1.5...1.5,
                positionEndZRandomRange: 3...9,
                size: [9, 9],
                sizeRandomRange: 7...11
            ),
            .`3D`(
                kind: .texture("effect\\pok3.tga"),
                duration: 1.1,
                delayLate: 0.2,
                duplicate: EffectParameters.Duplicate(count: 10, interval: 0.05),
                attachedToTarget: true,
                zIndex: 1,
                blendMode: .one,
                alphaMax: 0.8,
                fadesIn: true,
                fadesOut: true,
                positionEnd: [0, 0, 6],
                positionXRandomRange: -1...1,
                positionYRandomRange: -1...1,
                positionStartZRandomRange: -1...1,
                size: [9, 9],
                sizeRandomRange: 7...11
            ),
        ],
        .ef_heal4: [
            .cylinder(
                textureName: "ring_white.tga",
                soundName: "_heal_effect.wav",
                duration: 1.5,
                attachedToTarget: true,
                blendMode: .one,
                color: [0.7, 1, 0.7],
                alpha: 0.3,
                fades: true,
                topRadius: 1.1,
                bottomRadius: 1.1,
                height: 18,
                animation: .growHeight,
                rotatesContinuously: true
            ),
            .cylinder(
                textureName: "ring_white.tga",
                soundName: "_heal_effect.wav",
                duration: 1.5,
                attachedToTarget: true,
                blendMode: .one,
                color: [0.7, 1, 0.7],
                alpha: 0.3,
                fades: true,
                topRadius: 1,
                bottomRadius: 1,
                height: 15,
                animation: .growHeight,
                rotatesContinuously: true
            ),
            .cylinder(
                textureName: "ring_white.tga",
                duration: 1.5,
                attachedToTarget: true,
                blendMode: .one,
                color: [0.7, 1, 0.7],
                alpha: 0.3,
                fades: true,
                topRadius: 3,
                bottomRadius: 1.1,
                height: 3,
                animation: .growHeight,
                rotatesContinuously: true
            ),
            .`3D`(
                kind: .texture("effect\\pok3.tga"),
                duration: 1.5,
                duplicate: EffectParameters.Duplicate(count: 7, interval: 0.01),
                attachedToTarget: true,
                zIndex: 1,
                blendMode: .one,
                alphaMax: 0.8,
                fadesIn: true,
                fadesOut: true,
                sparkles: true,
                sparkleCount: 3,
                positionXRandomRange: -1.2...1.2,
                positionYRandomRange: -1.2...1.2,
                positionEndZRandomRange: 7...9,
                size: [9, 9],
                sizeRandomRange: 7...11
            ),
            .`3D`(
                kind: .texture("effect\\pok3.tga"),
                duration: 1.3,
                delayOffset: 0.4,
                duplicate: EffectParameters.Duplicate(count: 25, interval: 0.01),
                attachedToTarget: true,
                zIndex: 1,
                blendMode: .one,
                alphaMax: 0.8,
                fadesIn: true,
                fadesOut: true,
                sparkles: true,
                sparkleCount: 3,
                positionXRandomRange: -1.5...1.5,
                positionYRandomRange: -1.5...1.5,
                positionEndZRandomRange: 3...9,
                size: [10, 10],
                sizeRandomRange: 5...15
            ),
            .`3D`(
                kind: .texture("effect\\pok3.tga"),
                duration: 1.1,
                delayLate: 0.2,
                duplicate: EffectParameters.Duplicate(count: 15, interval: 0.05),
                attachedToTarget: true,
                zIndex: 1,
                blendMode: .one,
                alphaMax: 0.8,
                fadesIn: true,
                fadesOut: true,
                positionEnd: [0, 0, 6],
                positionXRandomRange: -1...1,
                positionYRandomRange: -1...1,
                positionStartZRandomRange: -1...1,
                size: [11, 11],
                sizeRandomRange: 9...13
            ),
        ],
        .ef_heal_n: [
            .wav(soundName: K2L("effect\\기공포.wav")),
        ],
        .ef_heartasura: [
            .wav(soundName: K2L("effect\\세이렌의목소리.wav")),
        ],
        .ef_hitline2: [
            .wav(soundName: K2L("effect\\맹호경파산.wav")),
        ],
        .ef_holycross: [
            .str(
                fileName: "holy_cross.str",
                soundName: "effect\\cru_holy cross.wav",
                attachedToTarget: true
            ),
        ],
        .ef_holyhit: [
            .str(
                fileName: "holyhit.str",
                attachedToTarget: true
            ),
        ],
        .ef_ign_str: [
            .str(
                fileName: K2L("이그니션브레이크.str"),
                soundName: "effect\\wl_jackfrost.wav",
                attachedToTarget: true
            ),
        ],
        .ef_impositio: [
            .str(
                fileName: "impositio.str",
                soundName: "effect\\priest_impositio.wav",
                attachedToTarget: true
            ),
        ],
        .ef_kyrie: [
            .str(
                fileName: "kyrie.str",
                soundName: "effect\\priest_kyrie_eleison_a.wav",
                attachedToTarget: true
            ),
        ],
        .ef_lexaeterna: [
            .str(
                fileName: "lexaeterna.str",
                soundName: "effect\\priest_lexaeterna.wav",
                attachedToTarget: true
            ),
        ],
        .ef_lexdivina: [
            .str(
                fileName: "lexdivina.str",
                soundName: "effect\\priest_lexdivina.wav",
                attachedToTarget: true
            ),
        ],
        .ef_lkconcentration: [
            .str(
                fileName: "twohand.str",
                soundName: "effect\\knight_twohandquicken.wav",
                attachedToTarget: true
            ),
        ],
        .ef_m05: [
            .spr(
                fileName: "m_ef05",
                soundName: "dragon_breath.wav",
                attachedToTarget: true
            ),
        ],
        .ef_magnificat: [
            .str(
                fileName: "magnificat.str",
                soundName: "effect\\priest_magnificat.wav",
                attachedToTarget: true
            ),
        ],
        .ef_magnum2: [
            .wav(soundName: "permeter_attack.wav"),
            .wav(soundName: "effect\\ef_magnumbreak.wav", delaySound: 0.3),
        ],
        .ef_milshield_str: [
            .str(
                fileName: "mil_shield.str",
                attachedToTarget: true
            ),
        ],
        .ef_pattack: [
            .`3D`(
                kind: .texture("effect\\pok1.tga"),
                duration: 1,
                duplicate: EffectParameters.Duplicate(count: 10, interval: 0.2),
                attachedToTarget: true,
                zIndex: 1,
                color: [1, 0.7, 1],
                alphaMax: 1,
                fadesIn: true,
                fadesOut: true,
                positionEnd: [0, 0, 5],
                positionXRandomRange: -1...1,
                positionYRandomRange: -1...1,
                sizeRandomRange: 80...120
            ),
            .wav(soundName: "effect\\ef_detoxication.wav"),
        ],
        .ef_pierceself: [
            .str(
                fileName: "pierce.str",
                attachedToTarget: true
            ),
        ],
        .ef_pneuma: [
            .str(
                fileName: "pneuma%d.str",
                randomNumberRange: 1...3,
                attachedToTarget: false
            ),
        ],
        .ef_portal4: [
            .wav(soundName: K2L("effect\\윈드워크.wav")),
        ],
        .ef_potion_berserk2: [
            .str(
                fileName: K2L("버서크.str"),
                attachedToTarget: true
            ),
        ],
        .ef_pressure: [
            .`3D`(
                kind: .texture("effect\\cross_old.bmp"),
                soundName: K2L("effect\\프레셔.wav"),
                duration: 0.5,
                attachedToTarget: true,
                zIndex: 1,
                blendMode: .one,
                alphaMax: 0.6,
                positionStart: [0, 0, 20],
                positionEnd: [0, 0, 5],
                angle: 0,
                targetAngle: -611,
                rotates: true
            ),
            .`3D`(
                kind: .texture("effect\\cross_old.bmp"),
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
    ]

    private static let ids3: [EffectID : [EffectDefinition]] = [
        .ef_pressure2: [
            .`3D`(
                kind: .texture("effect\\shield.bmp"),
                soundName: K2L("effect\\프레셔.wav"),
                duration: 0.5,
                attachedToTarget: true,
                zIndex: 1,
                blendMode: .one,
                alphaMax: 0.6,
                positionStart: [0, 0, 20],
                positionEnd: [0, 0, 5],
                angle: 0,
                targetAngle: -611,
                rotates: true
            ),
            .`3D`(
                kind: .texture("effect\\shield.bmp"),
                soundName: "effect\\lg_shieldpress.wav",
                delaySound: 0.5,
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
        .ef_primecharge2: [
            .wav(soundName: "effect\\lg_prestige.wav"),
        ],
        .ef_primecharge3: [
            .wav(soundName: "effect\\lg_banding.wav"),
        ],
        .ef_primecharge4: [
            .wav(soundName: "effect\\lg_inspiration.wav"),
        ],
        .ef_providence: [
            .str(
                fileName: "providence.str",
                attachedToTarget: true
            ),
        ],
        .ef_rain_particle: [
            .wav(soundName: "effect\\rainstorm.wav"),
        ],
        .ef_recovery: [
            .str(
                fileName: "recovery.str",
                soundName: "effect\\priest_recovery.wav",
                attachedToTarget: true
            ),
        ],
        .ef_redbody: [
            .wav(soundName: K2L("effect\\버서크.wav")),
        ],
        .ef_reflectshield: [
            .cylinder(
                textureName: "ring_yellow.tga",
                duration: 3,
                attachedToTarget: true,
                blendMode: .oneMinusSourceAlpha,
                alpha: 0.6,
                fades: true,
                topRadius: 1.5,
                bottomRadius: 1.5,
                height: 10,
                animation: .growHeight,
                rotatesContinuously: true
            ),
        ],
        .ef_removetrap: [
            .wav(soundName: "effect\\hunter_removetrap.wav"),
        ],
        .ef_rk_luxanima: [
            .str(
                fileName: "rk_luxanima.str",
                attachedToTarget: true
            ),
        ],
        .ef_sanctuary: [
            .str(
                fileName: "sanctuary.str",
                soundName: "effect\\priest_sanctuary.wav",
                attachedToTarget: true
            ),
        ],
        .ef_sandman: [
            .str(
                fileName: "sandman.str",
                soundName: "effect\\hunter_sandman.wav",
                attachedToTarget: false
            ),
        ],
        .ef_secra2: [
            .wav(soundName: "effect\\ab_ancilla.wav"),
            .`3D`(
                kind: .texture("effect\\priest_spell.bmp"),
                duration: 1.5,
                attachedToTarget: true,
                zIndex: 10,
                blendMode: .one,
                color: [1, 0.55, 0.55],
                alphaMax: 0.3,
                fadesIn: true,
                fadesOut: true,
                offset: [0, 0, 7],
                sizeStart: [850, 850],
                sizeEnd: [100, 100],
                smoothSize: true
            ),
            .`3D`(
                kind: .texture("effect\\priest_spell.bmp"),
                duration: 1.5,
                attachedToTarget: true,
                zIndex: 10,
                blendMode: .one,
                color: [1, 0.6, 0.6],
                alphaMax: 0.3,
                fadesIn: true,
                fadesOut: true,
                offset: [0, 0, 7],
                sizeStart: [800, 800],
                sizeEnd: [100, 100],
                smoothSize: true
            ),
            .`3D`(
                kind: .texture("effect\\priest_spell.bmp"),
                duration: 1.5,
                attachedToTarget: true,
                zIndex: 10,
                blendMode: .one,
                color: [1, 0.65, 0.65],
                alphaMax: 0.3,
                fadesIn: true,
                fadesOut: true,
                offset: [0, 0, 7],
                sizeStart: [750, 750],
                sizeEnd: [100, 100],
                smoothSize: true
            ),
            .`3D`(
                kind: .texture("effect\\priest_spell.bmp"),
                duration: 1.5,
                attachedToTarget: true,
                zIndex: 10,
                blendMode: .one,
                color: [1, 0.7, 0.7],
                alphaMax: 0.3,
                fadesIn: true,
                fadesOut: true,
                offset: [0, 0, 7],
                sizeStart: [700, 700],
                sizeEnd: [100, 100],
                smoothSize: true
            ),
            .`3D`(
                kind: .texture("effect\\priest_spell.bmp"),
                duration: 1.5,
                attachedToTarget: true,
                zIndex: 10,
                blendMode: .one,
                color: [1, 0.75, 0.75],
                alphaMax: 0.3,
                fadesIn: true,
                fadesOut: true,
                offset: [0, 0, 7],
                sizeStart: [650, 650],
                sizeEnd: [100, 100],
                smoothSize: true
            ),
            .`3D`(
                kind: .texture("effect\\priest_spell.bmp"),
                duration: 1.5,
                attachedToTarget: true,
                zIndex: 10,
                blendMode: .one,
                color: [1, 0.8, 0.8],
                alphaMax: 0.3,
                fadesIn: true,
                fadesOut: true,
                offset: [0, 0, 7],
                sizeStart: [600, 600],
                sizeEnd: [100, 100],
                smoothSize: true
            ),
            .`3D`(
                kind: .texture("effect\\priest_spell.bmp"),
                duration: 1.5,
                attachedToTarget: true,
                zIndex: 10,
                blendMode: .one,
                color: [1, 0.85, 0.85],
                alphaMax: 0.3,
                fadesIn: true,
                fadesOut: true,
                offset: [0, 0, 7],
                sizeStart: [550, 550],
                sizeEnd: [100, 100],
                smoothSize: true
            ),
            .`3D`(
                kind: .texture("effect\\priest_spell.bmp"),
                duration: 1.5,
                attachedToTarget: true,
                zIndex: 10,
                blendMode: .one,
                color: [1, 0.9, 0.9],
                alphaMax: 0.3,
                fadesIn: true,
                fadesOut: true,
                offset: [0, 0, 7],
                sizeStart: [500, 500],
                sizeEnd: [100, 100],
                smoothSize: true
            ),
            .`3D`(
                kind: .texture("effect\\priest_spell.bmp"),
                duration: 1.5,
                attachedToTarget: true,
                zIndex: 10,
                blendMode: .one,
                color: [1, 0.95, 0.95],
                alphaMax: 0.3,
                fadesIn: true,
                fadesOut: true,
                offset: [0, 0, 7],
                sizeStart: [450, 450],
                sizeEnd: [100, 100],
                smoothSize: true
            ),
            .`3D`(
                kind: .texture("effect\\priest_spell.bmp"),
                duration: 1.5,
                attachedToTarget: true,
                zIndex: 10,
                blendMode: .one,
                alphaMax: 0.3,
                fadesIn: true,
                fadesOut: true,
                offset: [0, 0, 7],
                sizeStart: [400, 400],
                sizeEnd: [100, 100],
                smoothSize: true
            ),
        ],
        .ef_shieldboomerang: [
            .wav(soundName: "effect\\cru_shield boomerang.wav"),
        ],
        .ef_shieldcharge: [
            .str(
                fileName: "shield_charge.str",
                attachedToTarget: true
            ),
        ],
        .ef_shockwave: [
            .spr(
                fileName: "shockwave",
                soundName: "effect\\hunter_shockwavetrap.wav",
                attachedToTarget: true
            ),
        ],
        .ef_shockwavehit: [
            .str(
                fileName: "shockwavehit.str",
                attachedToTarget: true
            ),
        ],
        .ef_skidtrap: [
            .str(
                fileName: "skidtrap.str",
                soundName: "effect\\hunter_skidtrap.wav",
                attachedToTarget: false
            ),
        ],
        .ef_slowpoison: [
            .str(
                fileName: "slowp.str",
                soundName: "effect\\priest_slowpoison.wav",
                attachedToTarget: false
            ),
        ],
        .ef_soulbreaker: [
            .`3D`(
                kind: .texture("effect\\purpleslash.tga"),
                soundName: K2L("effect\\기공포.wav"),
                duration: 0.5,
                attachedToTarget: true,
                zIndex: 10,
                alphaMax: 0.4,
                fadesIn: true,
                fadesOut: true,
                offset: [0, 0, 2],
                movesFromSource: true,
                sizeStart: [100, 100],
                sizeEnd: [200, 200],
                angle: 90,
                rotatesToTarget: true,
                rotatesWithCamera: true
            ),
        ],
        .ef_soulbreaker2: [
            .wav(soundName: K2L("effect\\메테오 어썰트.wav")),
            .`3D`(
                kind: .texture("effect\\purpleslash.tga"),
                duration: 0.5,
                attachedToTarget: false,
                zIndex: 10,
                alphaMax: 0.6,
                fadesOut: true,
                positionStart: [-1, 0, 0],
                positionEnd: [-5, 0, 0],
                sizeStart: [100, 100],
                sizeEnd: [200, 200],
                angle: 0,
                rotatesWithCamera: true
            ),
            .`3D`(
                kind: .texture("effect\\purpleslash.tga"),
                duration: 0.5,
                attachedToTarget: false,
                zIndex: 10,
                alphaMax: 0.6,
                fadesOut: true,
                positionStart: [-0.7, -0.7, 0],
                positionEnd: [-3.53, -3.53, 0],
                sizeStart: [100, 100],
                sizeEnd: [200, 200],
                angle: -45,
                rotatesWithCamera: true
            ),
            .`3D`(
                kind: .texture("effect\\purpleslash.tga"),
                duration: 0.5,
                attachedToTarget: false,
                zIndex: 10,
                alphaMax: 0.6,
                fadesOut: true,
                positionStart: [0, -1, 0],
                positionEnd: [0, -5, 0],
                sizeStart: [100, 100],
                sizeEnd: [200, 200],
                angle: -90,
                rotatesWithCamera: true
            ),
            .`3D`(
                kind: .texture("effect\\purpleslash.tga"),
                duration: 0.5,
                attachedToTarget: false,
                zIndex: 10,
                alphaMax: 0.6,
                fadesOut: true,
                positionStart: [0.7, -0.7, 0],
                positionEnd: [3.53, -3.53, 0],
                sizeStart: [100, 100],
                sizeEnd: [200, 200],
                angle: -135,
                rotatesWithCamera: true
            ),
            .`3D`(
                kind: .texture("effect\\purpleslash.tga"),
                duration: 0.5,
                attachedToTarget: false,
                zIndex: 10,
                alphaMax: 0.6,
                fadesOut: true,
                positionStart: [1, 0, 0],
                positionEnd: [5, 0, 0],
                sizeStart: [100, 100],
                sizeEnd: [200, 200],
                angle: -180,
                rotatesWithCamera: true
            ),
            .`3D`(
                kind: .texture("effect\\purpleslash.tga"),
                duration: 0.5,
                attachedToTarget: false,
                zIndex: 10,
                alphaMax: 0.6,
                fadesOut: true,
                positionStart: [0.7, 0.7, 0],
                positionEnd: [3.53, 3.53, 0],
                sizeStart: [100, 100],
                sizeEnd: [200, 200],
                angle: -225,
                rotatesWithCamera: true
            ),
            .`3D`(
                kind: .texture("effect\\purpleslash.tga"),
                duration: 0.5,
                attachedToTarget: false,
                zIndex: 10,
                alphaMax: 0.6,
                fadesOut: true,
                positionStart: [0, 1, 0],
                positionEnd: [0, 5, 0],
                sizeStart: [100, 100],
                sizeEnd: [200, 200],
                angle: -270,
                rotatesWithCamera: true
            ),
            .`3D`(
                kind: .texture("effect\\purpleslash.tga"),
                duration: 0.5,
                attachedToTarget: false,
                zIndex: 10,
                alphaMax: 0.6,
                fadesOut: true,
                positionStart: [-0.7, 0.7, 0],
                positionEnd: [-3.53, 3.53, 0],
                sizeStart: [100, 100],
                sizeEnd: [200, 200],
                angle: -315,
                rotatesWithCamera: true
            ),
        ],
        .ef_spearbmr: [
            .wav(soundName: "effect\\ef_fireball.wav"),
        ],
        .ef_spearbmrself: [
            .str(
                fileName: "spearboomerang.str",
                soundName: "effect\\knight_spear_boomerang.wav",
                attachedToTarget: true
            ),
        ],
        .ef_spearquicken: [
            .str(
                fileName: "twohand.str",
                soundName: "effect\\knight_twohandquicken.wav",
                attachedToTarget: true
            ),
        ],
        .ef_spearstabself: [
            .str(
                fileName: "spearstab.str",
                soundName: "_enemy_hit_normal1.wav",
                attachedToTarget: true
            ),
        ],
        .ef_spr_plant2: [
            .wav(soundName: K2L("effect\\워그와함께춤을.wav")),
        ],
        .ef_spr_plant3: [
            .wav(soundName: K2L("effect\\마나의노래.wav")),
        ],
        .ef_spr_plant4: [
            .wav(soundName: K2L("effect\\새터데이나이트피버.wav")),
        ],
        .ef_spr_plant5: [
            .wav(soundName: K2L("effect\\레라드의이슬.wav")),
        ],
    ]

    private static let ids4: [EffectID : [EffectDefinition]] = [
        .ef_spr_plant6: [
            .wav(soundName: K2L("effect\\멜로디오브싱크.wav")),
        ],
        .ef_spr_plant7: [
            .wav(soundName: K2L("effect\\비욘드오브워크라이.wav")),
        ],
        .ef_spr_plant8: [
            .wav(soundName: K2L("effect\\언리미티드허밍보이스.wav")),
        ],
        .ef_springtrap: [
            .str(
                fileName: "spring.str",
                soundName: "effect\\hunter_springtrap.wav",
                attachedToTarget: false
            ),
        ],
        .ef_sr_flashcombo: [
            .str(
                fileName: "sr_flashcombo.str",
                soundName: "effect\\sr_flashcombo.wav",
                attachedToTarget: true
            ),
        ],
        .ef_steal: [
            .`3D`(
                kind: .texture("effect\\pok1.tga"),
                duration: 0.5,
                duplicate: EffectParameters.Duplicate(count: 7, interval: 0),
                attachedToTarget: false,
                zIndex: 10,
                color: [1, 1, 0.85],
                alphaMax: 1,
                fadesOut: true,
                positionEndXRandomRange: -3.5...3.5,
                positionEndYRandomRange: -3.5...3.5,
                positionEndZRandomRange: 2...4,
                sizeStart: [200, 200],
                sizeEnd: [10, 10]
            ),
            .wav(soundName: "effect\\ef_steal.wav"),
        ],
        .ef_steelbody: [
            .wav(soundName: K2L("effect\\mon_금강불괴.wav")),
        ],
        .ef_suffragium: [
            .str(
                fileName: "suffragium.str",
                soundName: "effect\\priest_suffragium.wav",
                attachedToTarget: true
            ),
        ],
        .ef_tanji: [
            .`3D`(
                kind: .texture("effect\\blue_ivy.bmp"),
                soundName: K2L("effect\\mon_탄지신통.wav"),
                duration: 0.15,
                attachedToTarget: true,
                blendMode: .one,
                alphaMax: 1,
                movesFromSource: true,
                size: [50, 50],
                angle: 90,
                rotatesToTarget: true,
                rotatesWithCamera: true
            ),
        ],
        .ef_teihit1: [
            .`3D`(
                kind: .texture("effect\\alpha_center.tga"),
                soundName: K2L("effect\\mon_폭기.wav"),
                duration: 0.55,
                delayStart: 0.25,
                duplicate: EffectParameters.Duplicate(count: 12, interval: 0),
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
        .ef_throwitem3: [
            .`3D`(
                kind: .texture(K2L("유저인터페이스\\item\\돌.bmp")),
                duration: 0.2,
                attachedToTarget: true,
                zIndex: 1,
                alphaMax: 1,
                fadesIn: true,
                fadesOut: true,
                movesFromSource: true,
                size: [20, 20],
                angle: 180,
                rotates: true,
                rotationCount: 0.5,
                rotatesToTarget: true,
                rotatesWithCamera: true
            ),
        ],
        .ef_throwitem6: [
            .`3D`(
                kind: .texture(K2L("유저인터페이스\\item\\베넘나이프.bmp")),
                duration: 0.2,
                attachedToTarget: true,
                zIndex: 1,
                alphaMax: 1,
                fadesIn: true,
                fadesOut: true,
                movesFromSource: true,
                size: [30, 30],
                angle: 180,
                rotates: true,
                rotationCount: 1,
                rotatesToTarget: true,
                rotatesWithCamera: true
            ),
        ],
        .ef_tripleattack: [
            .wav(soundName: "effect\\ef_hit2.wav"),
            .wav(soundName: "effect\\ef_hit4.wav", delaySound: 0.2),
            .wav(soundName: "effect\\ef_hit2.wav", delaySound: 0.4),
        ],
        .ef_tripleattack2: [
            .wav(soundName: K2L("effect\\샤프슈팅.wav")),
        ],
        .ef_tripleattack3: [
            .wav(soundName: K2L("effect\\애로우 발칸.wav")),
        ],
        .ef_truesight: [
            .wav(soundName: "effect\\hunter_detecting.wav"),
        ],
        .ef_twohandquicken: [
            .str(
                fileName: "twohand.str",
                soundName: "effect\\knight_twohandquicken.wav",
                attachedToTarget: true
            ),
        ],
        .ef_wink: [
            .spr(
                fileName: "wink",
                attachedToTarget: false
            ),
        ],
    ]

    private static let named0: [String : [EffectDefinition]] = [
        "517_music": [
            .wav(soundName: K2L("effect\\헤르모드의 지팡이.wav")),
        ],
        "ef_ab_secrament": [
            .str(
                fileName: "new_secrament\\new_secrament\\new_secrament.str",
                attachedToTarget: false
            ),
        ],
        "ef_ancilla": [
            .wav(soundName: "effect\\ab_ancilla.wav"),
        ],
        "ef_banishingpoint": [
            .wav(soundName: "effect\\lg_banishingpoint.wav"),
        ],
        "ef_cannonspear": [
            .wav(soundName: "effect\\lg_cannonspear.wav"),
        ],
        "ef_cd_arbitrium": [
            .str(
                fileName: "arbitrium\\arbitrium\\arbitrium.str",
                soundName: "effect\\cd_arbitrium.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "arbitrium\\arbitrium_bottom\\arbitrium_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_cd_arbitrium_atk": [
            .str(
                fileName: "arbitrium\\arbitrium_hit\\arbitrium_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_cd_arbitrium_cast": [
            .str(
                fileName: "arbitrium\\arbitrium_cast\\arbitrium_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "arbitrium\\arbitrium_cast_bottom\\arbitrium_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_cd_arbitrium_hit": [
            .str(
                fileName: "arbitrium\\arbitrium_hit\\arbitrium_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_cd_argutus_telum": [
            .str(
                fileName: "argutustelum\\argutustelum\\argutustelum.str",
                attachedToTarget: false
            ),
        ],
        "ef_cd_argutus_telum_cast": [
            .str(
                fileName: "argutustelum\\argutustelum_cast\\argutustelum_cast.str",
                attachedToTarget: false
            ),
        ],
        "ef_cd_argutus_vita": [
            .str(
                fileName: "argutusvita\\argutusvita\\argutusvita.str",
                soundName: "effect\\cd_argutus_vita.wav",
                attachedToTarget: false
            ),
        ],
        "ef_cd_argutus_vita_cast": [
            .str(
                fileName: "argutusvita\\argutusvita_cast\\argutusvita_cast.str",
                attachedToTarget: false
            ),
        ],
        "ef_cd_benedictum": [
            .str(
                fileName: "benedictum\\benedictum\\benedictum.str",
                soundName: "effect\\cd_benedictum.wav",
                attachedToTarget: false
            ),
        ],
        "ef_cd_benedictum_cast": [
            .str(
                fileName: "benedictum\\benedictum_cast\\benedictum_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "benedictum\\benedictum_cast_bottom\\benedictum_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_cd_competentia": [
            .str(
                fileName: "competentia\\competentia\\competentia.str",
                soundName: "effect\\cd_competentia.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "competentia\\competentia_bottom\\competentia_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_cd_competentia_cast": [
            .str(
                fileName: "competentia\\competentia_cast\\competentia_cast.str",
                attachedToTarget: false
            ),
        ],
        "ef_cd_dilectio_heal": [
            .str(
                fileName: "new_dilectioheal\\new_dilectioheal\\new_dilectioheal.str",
                soundName: "effect\\cd_dilectio_heal.wav",
                attachedToTarget: false
            ),
        ],
        "ef_cd_dilectio_heal_cast": [
            .str(
                fileName: "new_dilectioheal\\new_dilectioheal_cast\\new_dilectioheal_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_dilectioheal\\new_dilectioheal_cast_bottom\\new_dilectioheal_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_cd_effligo": [
            .str(
                fileName: "effligo\\effligo\\effligo.str",
                soundName: "effect\\cd_effligo.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "effligo\\effligo_bottom\\effligo_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_cd_effligo_hit": [
            .str(
                fileName: "effligo\\effligo_hit\\effligo_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_cd_framen": [
            .wav(soundName: "effect\\cd_framen.wav"),
        ],
        "ef_cd_mediale_votum": [
            .str(
                fileName: "medialevotum\\medialevotum\\medialevotum.str",
                soundName: "effect\\cd_mediale_votum.wav",
                attachedToTarget: false
            ),
        ],
        "ef_cd_mediale_votum_cast": [
            .str(
                fileName: "medialevotum\\medialevotum_cast\\medialevotum_cast.str",
                attachedToTarget: false
            ),
        ],
        "ef_cd_petitio": [
            .str(
                fileName: "petitio\\petitio\\petitio.str",
                soundName: "effect\\cd_petitio.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "petitio\\petitio_bottom\\petitio_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_cd_pneumaticus_procella": [
            .str(
                fileName: "new_pneumaticusprocella\\new_pneumaticusprocella\\new_pneumaticusprocella.str",
                soundName: "effect\\cd_pneumaticus_procella.wav",
                attachedToTarget: false
            ),
        ],
        "ef_cd_pneumaticus_procella_cast": [
            .str(
                fileName: "new_pneumaticusprocella\\new_pneumaticusprocella_cast\\new_pneumaticusprocella_cast.str",
                attachedToTarget: false
            ),
        ],
        "ef_cd_presens_acies": [
            .str(
                fileName: "presensacies\\presensacies\\presensacies.str",
                soundName: "effect\\cd_presens_acies.wav",
                attachedToTarget: false
            ),
        ],
        "ef_cd_presens_acies_cast": [
            .str(
                fileName: "presensacies\\presensacies_cast\\presensacies_cast.str",
                attachedToTarget: false
            ),
        ],
        "ef_cd_religio": [
            .str(
                fileName: "religio\\religio\\religio.str",
                soundName: "effect\\cd_religio.wav",
                attachedToTarget: false
            ),
        ],
    ]

    private static let named1: [String : [EffectDefinition]] = [
        "ef_cd_religio_cast": [
            .str(
                fileName: "religio\\religio_cast\\religio_cast.str",
                attachedToTarget: false
            ),
        ],
        "ef_cd_reparatio": [
            .str(
                fileName: "new_reparatio\\new_reparatio\\new_reparatio.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_reparatio\\new_reparatio_bottom\\new_reparatio_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_cd_reparatio_cast": [
            .str(
                fileName: "new_reparatio\\new_reparatio_cast\\new_reparatio_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_reparatio\\new_reparatio_cast_bottom\\new_reparatio_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_crescentelbow": [
            .wav(soundName: "effect\\sr_crescentelbow.wav"),
        ],
        "ef_cursedcircle": [
            .wav(soundName: "effect\\sr_cursedcircle.wav"),
        ],
        "ef_dk_chargingpierce_cast": [
            .str(
                fileName: "dragon_knight\\dk_chargingpierce\\chargingpierce_cast\\chargingpierce_cast.str",
                soundName: "effect\\dk_chargingpierce1.wav",
                attachedToTarget: false,
                fallbackFileNames: ["new_chargingpierce\\new_chargingpierce_cast\\new_chargingpierce_cast.str"]
            ),
            .str(
                fileName: "dragon_knight\\dk_chargingpierce\\chargingpierce_cast_bottom\\chargingpierce_cast_bottom.str",
                attachedToTarget: false,
                fallbackFileNames: ["new_chargingpierce\\new_chargingpierce_cast_bottom\\new_chargingpierce_cast_bottom.str"]
            ),
        ],
        "ef_dk_chargingpierce_hit": [
            .str(
                fileName: "dragon_knight\\dk_chargingpierce\\chargingpierce_hit\\chargingpierce_hit.str",
                soundName: "effect\\dk_chargingpierce2.wav",
                attachedToTarget: false,
                fallbackFileNames: ["new_chargingpierce\\new_chargingpierce_hit\\new_chargingpierce_hit.str"]
            ),
        ],
        "ef_dk_dragonic_aura": [
            .wav(soundName: "effect\\dk_dragonic_aura1.wav"),
        ],
        "ef_dk_dragonic_breath": [
            .str(
                fileName: "dragon_knight\\dragonic_breath\\dragonic_breath\\dragonic_breath.str",
                soundName: "effect\\dk_dragonic_breath.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "dragon_knight\\dragonic_breath\\dragonic_breath_bottom\\dragonic_breath_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_dk_dragonic_breath_hit": [
            .str(
                fileName: "dragon_knight\\dragonic_breath\\dragonic_breath_hit\\dragonic_breath_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_dk_hackandslasher": [
            .str(
                fileName: "dragon_knight\\dk_hackandslasher\\hackandslash\\hackandslash.str",
                soundName: "effect\\dk_hackandslasher.wav",
                attachedToTarget: false,
                fallbackFileNames: ["hackandslash\\hackandslash\\hackandslash.str"]
            ),
            .str(
                fileName: "dragon_knight\\dk_hackandslasher\\hackandslash_bottom\\hackandslash_bottom.str",
                attachedToTarget: false,
                fallbackFileNames: ["hackandslash\\hackandslash_bottom\\hackandslash_bottom.str"]
            ),
        ],
        "ef_dk_hackandslasher_atk": [
            .str(
                fileName: "hackandslash\\hackandslash_hit\\hackandslash_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_dk_hackandslasher_hit": [
            .str(
                fileName: "dragon_knight\\dk_hackandslasher\\hackandslash_hit\\hackandslash_hit.str",
                attachedToTarget: false,
                fallbackFileNames: ["hackandslash\\hackandslash_hit\\hackandslash_hit.str"]
            ),
        ],
        "ef_dk_madness_crusher": [
            .str(
                fileName: "dragon_knight\\dk_madness_crusher\\madness_crusher\\madness_crusher.str",
                soundName: "effect\\dk_madness_crusher.wav",
                attachedToTarget: false,
                fallbackFileNames: ["madness_crusher\\madness_crusher\\madness_crusher.str"]
            ),
            .str(
                fileName: "dragon_knight\\dk_madness_crusher\\madness_crusher_bottom\\madness_crusher_bottom.str",
                attachedToTarget: false,
                fallbackFileNames: ["madness_crusher\\madness_crusher_bottom\\madness_crusher_bottom.str"]
            ),
        ],
        "ef_dk_servant_w_demol_hit": [
            .str(
                fileName: "dragon_knight\\dk_servant_w_demol\\servant_demolition_hit\\servant_demolition_hit.str",
                soundName: "effect\\dk_servant_w_demol.wav",
                attachedToTarget: false,
                fallbackFileNames: ["servant_demolition\\servant_demolition_hit\\servant_demolition_hit.str"]
            ),
        ],
        "ef_dk_servant_w_phantom": [
            .str(
                fileName: "dragon_knight\\dk_servant_w_phantom\\servant_phantom_sub\\servant_phantom_sub.str",
                soundName: "effect\\dk_servant_w_phantom.wav",
                attachedToTarget: false,
                fallbackFileNames: ["servant_phantom\\servant_phantom_sub\\servant_phantom_sub.str"]
            ),
            .str(
                fileName: "dragon_knight\\dk_servant_w_phantom\\servant_phantom_sub_bottom\\servant_phantom_sub_bottom.str",
                attachedToTarget: false,
                fallbackFileNames: ["servant_phantom\\servant_phantom_sub_bottom\\servant_phantom_sub_bottom.str"]
            ),
        ],
        "ef_dk_servant_w_sign": [
            .wav(soundName: "effect\\dk_servant_w_sign.wav"),
        ],
        "ef_dk_servantweapon": [
            .str(
                fileName: "dragon_knight\\dk_servantweapon\\servantweapon\\servantweapon.str",
                soundName: "effect\\dk_servantweapon.wav",
                attachedToTarget: false,
                fallbackFileNames: ["new_servantweapon\\new_servantweapon\\new_servantweapon.str"]
            ),
        ],
        "ef_dk_servantweapon_atk": [
            .str(
                fileName: "new_servantweapon\\new_servantweapon_hit\\new_servantweapon_hit.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_servantweapon\\new_servantweapon_hit_bottom\\new_servantweapon_hit_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_dk_servantweapon_cast": [
            .str(
                fileName: "dragon_knight\\dk_servantweapon\\servantweapon_cast\\servantweapon_cast.str",
                attachedToTarget: false,
                fallbackFileNames: ["new_servantweapon\\new_servantweapon_cast\\new_servantweapon_cast.str"]
            ),
        ],
        "ef_dk_servantweapon_hit": [
            .str(
                fileName: "dragon_knight\\dk_servantweapon\\servantweapon_hit\\servantweapon_hit.str",
                attachedToTarget: false,
                fallbackFileNames: ["new_servantweapon\\new_servantweapon_hit\\new_servantweapon_hit.str"]
            ),
            .str(
                fileName: "dragon_knight\\dk_servantweapon\\servantweapon_hit_bottom\\servantweapon_hit_bottom.str",
                attachedToTarget: false,
                fallbackFileNames: ["new_servantweapon\\new_servantweapon_hit_bottom\\new_servantweapon_hit_bottom.str"]
            ),
        ],
        "ef_dk_stormslash_hit": [
            .str(
                fileName: "dragon_knight\\dk_stormslash\\stormslash\\stormslash_%d.str",
                soundName: "effect\\dk_stormslash1.wav",
                randomNumberRange: 1...5,
                attachedToTarget: false,
                fallbackFileNames: ["stormslash\\stormslash\\stormslash_%d.str"]
            ),
        ],
        "ef_dk_vigor": [
            .wav(soundName: "effect\\dk_vigor.wav"),
        ],
        "ef_dk_vigor_cast": [
            .str(
                fileName: "dragon_knight\\dk_vigor\\vigor_cast\\vigor_cast.str",
                attachedToTarget: false,
                fallbackFileNames: ["vigor\\vigor_cast\\vigor_cast.str"]
            ),
        ],
        "ef_dragonbreath_water": [
            .spr(
                fileName: "rk_dragonbreath_water",
                soundName: "dragon_breath.wav",
                attachedToTarget: true
            ),
        ],
        "ef_dragoncombo": [
            .wav(soundName: "effect\\sr_dragoncombo.wav"),
        ],
        "ef_duplelight": [
            .wav(soundName: "effect\\ab_duplelight.wav"),
        ],
        "ef_earthdrive": [
            .wav(soundName: "effect\\lg_earthdrive.wav"),
        ],
        "ef_echo_song": [
            .wav(soundName: K2L("effect\\메아리의노래.wav")),
        ],
        "ef_exceedbreak": [
            .wav(soundName: "effect\\lg_exceedbreak.wav"),
        ],
    ]

    private static let named2: [String : [EffectDefinition]] = [
        "ef_fallenempire": [
            .wav(soundName: "effect\\sr_fallenempire.wav"),
        ],
        "ef_frigg_song": [
            .wav(soundName: "effect\\wm_frigg_song.wav"),
        ],
        "ef_gateofhell": [
            .wav(soundName: "effect\\sr_gateofhell.wav"),
        ],
        "ef_great_echo": [
            .wav(soundName: K2L("effect\\그레이트에코.wav")),
        ],
        "ef_harmonize": [
            .wav(soundName: K2L("effect\\하모나이즈.wav")),
        ],
        "ef_hesperuslit": [
            .wav(soundName: "effect\\lg_hesperuslit.wav"),
        ],
        "ef_howlingoflion": [
            .wav(soundName: "effect\\sr_howlingoflion.wav"),
        ],
        "ef_ht_landmine": [
            .str(
                fileName: "landmine.str",
                attachedToTarget: false
            ),
        ],
        "ef_ig_attack_stance": [
            .str(
                fileName: "imperial_guard\\ig_attack_stance\\new_attack_stance\\new_attack_stance\\new_attack_stance.str",
                attachedToTarget: false,
                fallbackFileNames: ["attack_stance\\attack_stance\\attack_stance.str"]
            ),
        ],
        "ef_ig_attack_stance_cast": [
            .str(
                fileName: "imperial_guard\\ig_attack_stance\\new_attack_stance\\new_attack_stance_cast\\new_attack_stance_cast.str",
                attachedToTarget: false,
                fallbackFileNames: ["attack_stance\\attack_stance_cast\\attack_stance_cast.str"]
            ),
            .str(
                fileName: "imperial_guard\\ig_attack_stance\\new_attack_stance\\new_attack_stance_cast_bottom\\new_attack_stance_cast_bottom.str",
                attachedToTarget: false,
                fallbackFileNames: ["attack_stance\\attack_stance_cast_bottom\\attack_stance_cast_bottom.str"]
            ),
        ],
        "ef_ig_cross_rain_cast": [
            .str(
                fileName: "imperial_guard\\ig_cross_rain\\new_crossrain\\new_cross_rain_cast\\new_cross_rain_cast.str",
                attachedToTarget: false,
                fallbackFileNames: ["crossrain\\cross_rain_cast\\cross_rain_cast.str"]
            ),
            .str(
                fileName: "imperial_guard\\ig_cross_rain\\new_crossrain\\new_cross_rain_cast_bottom\\new_cross_rain_cast_bottom.str",
                attachedToTarget: false,
                fallbackFileNames: ["crossrain\\cross_rain_cast_bottom\\cross_rain_cast_bottom.str"]
            ),
        ],
        "ef_ig_grand_judgement": [
            .str(
                fileName: "imperial_guard\\ig_grand_judgement\\new_grand_judgement\\new_grand_judgement\\new_grand_judgement.str",
                soundName: "effect\\ig_grand_judgement.wav",
                attachedToTarget: false,
                fallbackFileNames: ["grand_judgement\\grand_judgement\\grand_judgement.str"]
            ),
            .str(
                fileName: "imperial_guard\\ig_grand_judgement\\new_grand_judgement\\new_grand_judgement_bottom\\new_grand_judgement_bottom.str",
                attachedToTarget: false,
                fallbackFileNames: ["grand_judgement\\grand_judgement_bottom\\grand_judgement_bottom.str"]
            ),
        ],
        "ef_ig_grand_judgement_cast": [
            .str(
                fileName: "imperial_guard\\ig_grand_judgement\\new_grand_judgement\\grand_judgement_cast\\grand_judgement_cast.str",
                attachedToTarget: false,
                fallbackFileNames: ["grand_judgement\\grand_judgement_cast\\grand_judgement_cast.str"]
            ),
            .str(
                fileName: "imperial_guard\\ig_grand_judgement\\new_grand_judgement\\grand_judgement_cast_bottom\\grand_judgement_cast_bottom.str",
                attachedToTarget: false,
                fallbackFileNames: ["grand_judgement\\grand_judgement_cast_bottom\\grand_judgement_cast_bottom.str"]
            ),
        ],
        "ef_ig_guard_stance": [
            .str(
                fileName: "imperial_guard\\ig_guard_stance\\new_guard_stance\\new_guard_stance\\new_guard_stance.str",
                soundName: "effect\\ig_guard_stance.wav",
                attachedToTarget: false,
                fallbackFileNames: ["guard_stance\\guard_stance\\guard_stance.str"]
            ),
        ],
        "ef_ig_guard_stance_cast": [
            .str(
                fileName: "imperial_guard\\ig_guard_stance\\new_guard_stance\\new_guard_stance_cast\\new_guard_stance_cast.str",
                attachedToTarget: false,
                fallbackFileNames: ["guard_stance\\guard_stance_cast\\guard_stance_cast.str"]
            ),
            .str(
                fileName: "imperial_guard\\ig_guard_stance\\new_guard_stance\\new_guard_stance_cast_bottom\\new_guard_stance_cast_bottom.str",
                attachedToTarget: false,
                fallbackFileNames: ["guard_stance\\guard_stance_cast_bottom\\guard_stance_cast_bottom.str"]
            ),
        ],
        "ef_ig_guardian_shield": [
            .str(
                fileName: "imperial_guard\\ig_guardian_shield\\new_guardianshield\\guardianshield\\guardianshield.str",
                soundName: "effect\\ig_guardian_shield.wav",
                attachedToTarget: false,
                fallbackFileNames: ["guardianshield\\guardianshield\\guardianshield.str"]
            ),
            .str(
                fileName: "imperial_guard\\ig_guardian_shield\\new_guardianshield\\guardianshield_bottom\\guardianshield_bottom.str",
                attachedToTarget: false,
                fallbackFileNames: ["guardianshield\\guardianshield_bottom\\guardianshield_bottom.str"]
            ),
        ],
        "ef_ig_holy_shield": [
            .str(
                fileName: "imperial_guard\\ig_holy_shield\\new_holy_shield\\new_holy_shield\\new_holy_shield.str",
                attachedToTarget: false,
                fallbackFileNames: ["holy_shield\\holy_shield\\holy_shield.str"]
            ),
            .str(
                fileName: "imperial_guard\\ig_holy_shield\\new_holy_shield\\new_holy_shield_bottom\\new_holy_shield_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ig_holy_shield_cast": [
            .str(
                fileName: "imperial_guard\\ig_holy_shield\\new_holy_shield\\new_holy_shield_cast\\new_holy_shield_cast.str",
                attachedToTarget: false,
                fallbackFileNames: ["holy_shield\\holy_shield_cast\\holy_shield_cast.str"]
            ),
            .str(
                fileName: "imperial_guard\\ig_holy_shield\\new_holy_shield\\new_holy_shield_cast_bottom\\new_holy_shield_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_ig_judgement_cross": [
            .str(
                fileName: "imperial_guard\\ig_judgement_cross\\new_judgement_cross\\new_judgement_cross\\new_judgement_cross.str",
                soundName: "effect\\ig_judgement_cross.wav",
                attachedToTarget: false,
                fallbackFileNames: ["judgement_cross\\judgement_cross\\judgement_cross.str"]
            ),
            .str(
                fileName: "imperial_guard\\ig_judgement_cross\\new_judgement_cross\\new_judgement_cross_bottom\\new_judgement_cross_bottom.str",
                attachedToTarget: false,
                fallbackFileNames: ["judgement_cross\\judgement_cross_bottom\\judgement_cross_bottom.str"]
            ),
        ],
        "ef_ig_judgement_cross_cast": [
            .str(
                fileName: "imperial_guard\\ig_judgement_cross\\new_judgement_cross\\new_judgement_cross_cast\\new_judgement_cross_cast.str",
                attachedToTarget: false,
                fallbackFileNames: ["judgement_cross\\judgement_cross_cast\\judgement_cross_cast.str"]
            ),
            .str(
                fileName: "imperial_guard\\ig_judgement_cross\\new_judgement_cross\\new_judgement_cross_cast_bottom\\new_judgement_cross_cast_bottom.str",
                attachedToTarget: false,
                fallbackFileNames: ["judgement_cross\\judgement_cross_cast_bottom\\judgement_cross_cast_bottom.str"]
            ),
        ],
        "ef_ig_judgement_cross_hit": [
            .str(
                fileName: "imperial_guard\\ig_judgement_cross\\new_judgement_cross\\new_judgement_cross_hit\\new_judgement_cross_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_ig_overslash": [
            .str(
                fileName: "imperial_guard\\ig_overslash\\new_overslash\\new_overslash\\new_overslash.str",
                soundName: "effect\\ig_overslash.wav",
                attachedToTarget: false,
                fallbackFileNames: ["overslash\\overslash\\overslash.str"]
            ),
            .str(
                fileName: "imperial_guard\\ig_overslash\\new_overslash\\new_overslash_bottom\\new_overslash_bottom.str",
                attachedToTarget: false,
                fallbackFileNames: ["overslash\\overslash_bottom\\overslash_bottom.str"]
            ),
        ],
        "ef_ig_overslash_cast": [
            .str(
                fileName: "imperial_guard\\ig_overslash\\new_overslash\\overslash_cast\\overslash_cast.str",
                attachedToTarget: false,
                fallbackFileNames: ["overslash\\overslash_cast\\overslash_cast.str"]
            ),
        ],
        "ef_ig_overslash_hit": [
            .str(
                fileName: "imperial_guard\\ig_overslash\\new_overslash\\new_overslash_hit\\new_overslash_hit.str",
                attachedToTarget: false,
                fallbackFileNames: ["overslash\\overslash_hit\\overslash_hit.str"]
            ),
        ],
        "ef_ig_rebound_shield": [
            .str(
                fileName: "imperial_guard\\ig_rebound_shield\\new_rebound_shield\\new_rebound_shield\\new_rebound_shield.str",
                soundName: "effect\\ig_rebound_shield.wav",
                attachedToTarget: false,
                fallbackFileNames: ["rebound_shield\\rebound_shield\\rebound_shield.str"]
            ),
            .str(
                fileName: "imperial_guard\\ig_rebound_shield\\new_rebound_shield\\new_rebound_shield_bottom\\new_rebound_shield_bottom.str",
                attachedToTarget: false,
                fallbackFileNames: ["rebound_shield\\rebound_shield_bottom\\rebound_shield_bottom.str"]
            ),
        ],
        "ef_ig_rebound_shield_cast": [
            .str(
                fileName: "imperial_guard\\ig_rebound_shield\\new_rebound_shield\\rebound_shield_cast\\rebound_shield_cast.str",
                attachedToTarget: false,
                fallbackFileNames: ["rebound_shield\\rebound_shield_cast\\rebound_shield_cast.str"]
            ),
            .str(
                fileName: "imperial_guard\\ig_rebound_shield\\new_rebound_shield\\rebound_shield_cast_bottom\\rebound_shield_cast_bottom.str",
                attachedToTarget: false,
                fallbackFileNames: ["rebound_shield\\rebound_shield_cast_bottom\\rebound_shield_cast_bottom.str"]
            ),
        ],
        "ef_ig_shield_shooting": [
            .str(
                fileName: "shield_shooting\\shield_shooting\\shield_shooting.str",
                soundName: "effect\\ig_shield_shooting.wav",
                attachedToTarget: false
            ),
        ],
        "ef_ig_shield_shooting_cast": [
            .str(
                fileName: "shield_shooting\\shield_shooting_cast\\shield_shooting_cast.str",
                attachedToTarget: false
            ),
        ],
        "ef_ig_shield_shooting_hit": [
            .str(
                fileName: "shield_shooting\\shield_shooting_hit\\shield_shooting_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_ig_ultimate_sacrifice": [
            .str(
                fileName: "imperial_guard\\ig_ultimate_sacrifice\\ultimatesacrifice\\ultimatesacrifice.str",
                soundName: "effect\\ig_ultimate_sacrifice.wav",
                attachedToTarget: false,
                fallbackFileNames: ["ultimate_sacrifice\\ultimatesacrifice\\ultimatesacrifice.str"]
            ),
            .str(
                fileName: "imperial_guard\\ig_ultimate_sacrifice\\ultimatesacrifice_bottom\\ultimatesacrifice_bottom.str",
                attachedToTarget: false,
                fallbackFileNames: ["ultimate_sacrifice\\ultimatesacrifice_bottom\\ultimatesacrifice_bottom.str"]
            ),
        ],
    ]

    private static let named3: [String : [EffectDefinition]] = [
        "ef_iq_exposion_blaster": [
            .str(
                fileName: "4ig_explosionblaster\\explosionblaster\\explosionblaster.str",
                soundName: "effect\\iq_exposion_blaster.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "4ig_explosionblaster\\explosionblaster_bottom\\explosionblaster_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_iq_exposion_blaster_hit": [
            .str(
                fileName: "4ig_explosionblaster\\explosionblaster_hit\\explosionblaster_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_iq_firm_faith": [
            .str(
                fileName: "firmfaith\\firmfaith\\firmfaith.str",
                attachedToTarget: false
            ),
        ],
        "ef_iq_first_brand": [
            .str(
                fileName: "4ig_firstbrand\\firstbrand\\firstbrand.str",
                soundName: "effect\\iq_first_brand.wav",
                attachedToTarget: false
            ),
        ],
        "ef_iq_first_brand_hit": [
            .str(
                fileName: "4ig_firstbrand\\firstbrand_hit\\firstbrand_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_iq_first_faith_power": [
            .str(
                fileName: "4ig_firstfaithpower\\firstfaithpower\\firstfaithpower.str",
                soundName: "effect\\iq_first_faith_power.wav",
                attachedToTarget: false
            ),
        ],
        "ef_iq_first_faith_power_cast": [
            .str(
                fileName: "4ig_firstfaithpower\\firstfaithpower_cast\\firstfaithpower_cast.str",
                attachedToTarget: false
            ),
        ],
        "ef_iq_judge": [
            .str(
                fileName: "4ig_judge\\judge\\judge.str",
                soundName: "effect\\iq_judge.wav",
                attachedToTarget: false
            ),
        ],
        "ef_iq_judge_cast": [
            .str(
                fileName: "4ig_judge\\judge_cast\\judge_cast.str",
                attachedToTarget: false
            ),
        ],
        "ef_iq_massive_f_blaster": [
            .str(
                fileName: "4iq_massivefblaster\\massivefblaster\\massivefblaster.str",
                soundName: "effect\\iq_massive_f_blaster.wav",
                attachedToTarget: false
            ),
        ],
        "ef_iq_massive_f_blaster_hit": [
            .str(
                fileName: "4iq_massivefblaster\\massivefblaster_hit\\massivefblaster_hit.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "4iq_massivefblaster\\massivefblaster_hit_bottom\\massivefblaster_hit_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_iq_oleum_sanctum": [
            .str(
                fileName: "4ig_oleumsanctum\\oleumsanctum\\oleumsanctum.str",
                soundName: "effect\\iq_oleum_sanctum.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "4ig_oleumsanctum\\oleumsanctum_bottom\\oleumsanctum_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_iq_oleum_sanctum_hit": [
            .str(
                fileName: "4ig_oleumsanctum\\oleumsanctum_hit\\oleumsanctum_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_iq_powerful_faith": [
            .str(
                fileName: "powerfulfaith\\powerfulfaith\\powerfulfaith.str",
                attachedToTarget: false
            ),
        ],
        "ef_iq_second_faith": [
            .wav(soundName: "effect\\iq_second_faith.wav"),
        ],
        "ef_iq_second_flame": [
            .str(
                fileName: "4iq_secondflame\\secondflame\\secondflame.str",
                soundName: "effect\\iq_second_flame.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "4iq_secondflame\\secondflame_bottom\\secondflame_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_iq_second_judgement": [
            .str(
                fileName: "4iq_secondjudgement\\secondjudgement\\secondjudgement.str",
                soundName: "effect\\iq_second_judgement.wav",
                attachedToTarget: false
            ),
        ],
        "ef_iq_sincere_faith": [
            .str(
                fileName: "sincerefaith\\sincerefaith\\sincerefaith.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "sincerefaith\\sincerefaith_bottom\\sincerefaith_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_iq_third_consecration": [
            .str(
                fileName: "4iq_thirdconsecration\\thirdconsecration\\thirdconsecration.str",
                soundName: "effect\\iq_third_consecration.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "4iq_thirdconsecration\\thirdconsecration_bottom\\thirdconsecration_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_iq_third_exor_flame": [
            .str(
                fileName: "4ig_thirdexorflame\\thirdexorflame\\thirdexorflame.str",
                soundName: "effect\\iq_third_exor_flame.wav",
                attachedToTarget: false
            ),
        ],
        "ef_iq_third_exor_flame_cast": [
            .str(
                fileName: "4ig_thirdexorflame\\thirdexorflame_cast\\thirdexorflame_cast.str",
                attachedToTarget: false
            ),
        ],
        "ef_iq_third_flame_bomb": [
            .str(
                fileName: "4iq_thirdflamebomb\\thirdflamebomb\\thirdflamebomb.str",
                soundName: "effect\\iq_third_flame_bomb.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "4iq_thirdflamebomb\\thirdflamebomb_bottom\\thirdflamebomb_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_iq_third_punish": [
            .str(
                fileName: "4iq_thirdpunish\\thirdpunish\\thirdpunish.str",
                soundName: "effect\\iq_third_punish.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "4iq_thirdpunish\\thirdpunish_bottom\\thirdpunish_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_kings_grace": [
            .wav(soundName: "effect\\lg_kings_grace.wav"),
        ],
        "ef_knucklearrow": [
            .wav(soundName: "effect\\sr_knucklearrow.wav"),
        ],
        "ef_lg_banishingpoint_cast": [
            .str(
                fileName: "new_banishingpoint\\new_banishingpoint_cast\\new_banishingpoint_cast.str",
                soundName: "effect\\lg_banishingpoint.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_banishingpoint\\new_banishingpoint_cast_bottom\\new_banishingpoint_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_lg_cannonspear": [
            .str(
                fileName: "new_cannon_spear\\new_cannon_spear_bottom\\new_cannon_spear_bottom.str",
                soundName: "effect\\lg_cannonspear.wav",
                attachedToTarget: false
            ),
        ],
        "ef_lg_earthdrive": [
            .str(
                fileName: "new_earthdrive\\new_earthdrive\\new_earthdrive.str",
                soundName: "effect\\lg_earthdrive.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_earthdrive\\new_earthdrive_bottom\\new_earthdrive_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_lg_overbrand_cast": [
            .str(
                fileName: "new_overbrand\\new_overbrand_cast\\new_overbrand_cast.str",
                soundName: "effect\\lg_overbrand.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_overbrand\\new_overbrand_cast_bottom\\new_overbrand_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_lg_overbrand_hit": [
            .str(
                fileName: "new_overbrand\\new_overbrand_hit\\new_overbrand_hit.str",
                attachedToTarget: false
            ),
        ],
    ]

    private static let named4: [String : [EffectDefinition]] = [
        "ef_lg_rayofgenesis": [
            .str(
                fileName: "new_rayofgenesis\\new_rayofgenesis\\new_rayofgenesis.str",
                soundName: "effect\\lg_rayofgenesis.wav",
                attachedToTarget: false
            ),
        ],
        "ef_lg_rayofgenesis_cast": [
            .str(
                fileName: "new_rayofgenesis\\new_rayofgenesis_cast\\new_rayofgenesis_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_rayofgenesis\\new_rayofgenesis_cast_bottom\\new_rayofgenesis_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_lg_rayofgenesis_hit": [
            .str(
                fileName: "new_rayofgenesis\\new_rayofgenesis_hit\\new_rayofgenesis_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_lightningwalk": [
            .wav(soundName: "effect\\sr_lightningwalk.wav"),
        ],
        "ef_metalicsound": [
            .wav(soundName: "effect\\metalic.wav"),
        ],
        "ef_moonlit_serenade": [
            .wav(soundName: K2L("effect\\달빛세레나데.wav")),
        ],
        "ef_moonslasher": [
            .wav(soundName: "effect\\lg_moonslasher.wav"),
        ],
        "ef_overbrand": [
            .wav(soundName: "effect\\lg_overbrand.wav"),
        ],
        "ef_piety": [
            .wav(soundName: "effect\\lg_piety.wav"),
        ],
        "ef_pinpointattack": [
            .wav(soundName: "effect\\lg_pinpointattack.wav"),
        ],
        "ef_powervelocity": [
            .wav(soundName: "effect\\sr_powervelocity.wav"),
        ],
        "ef_ra_fearbreeze": [
            .str(
                fileName: "new_fearbreeze\\new_fearbreeze.str",
                attachedToTarget: false
            ),
        ],
        "ef_ra_unlimit": [
            .str(
                fileName: "new_unlimit\\new_unlimit\\new_unlimit.str",
                soundName: "ra_unlimit.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_unlimit\\new_unlimit_bottom\\new_unlimit_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_rageburst": [
            .wav(soundName: "effect\\lg_rageburst.wav"),
        ],
        "ef_raisingdragon": [
            .wav(soundName: "effect\\sr_raisingdragon.wav"),
        ],
        "ef_rampageblaster": [
            .wav(soundName: "effect\\sr_rampageblaster.wav"),
        ],
        "ef_rayofgenesis": [
            .wav(soundName: "effect\\lg_rayofgenesis.wav"),
        ],
        "ef_reflectdamage": [
            .wav(soundName: "effect\\lg_reflectdamage.wav"),
        ],
        "ef_rideinlightning": [
            .wav(soundName: "effect\\sr_rideinlightning.wav"),
        ],
        "ef_rk_windcutter": [
            .str(
                fileName: "new_windcutter\\new_windcutter\\new_windcutter.str",
                attachedToTarget: false
            ),
        ],
        "ef_rush_windmill": [
            .wav(soundName: K2L("effect\\풍차를향해돌격.wav")),
            .`3D`(
                kind: .texture("effect\\ac_center2.tga"),
                duration: 1,
                delayLate: 0.5,
                duplicate: EffectParameters.Duplicate(count: 7, interval: 0.2),
                attachedToTarget: true,
                color: [0.5, 0.01, 0.9],
                alphaMax: 1,
                fadesOut: true,
                positionXRandomRange: -1.5...1.5,
                positionYRandomRange: -1...1,
                positionStartZRandomRange: 0...2,
                positionEndZRandomRange: 5...7,
                size: [2.5, 100],
                sizeYRandomRange: 30...60
            ),
            .`3D`(
                kind: .texture("effect\\ac_center2.tga"),
                duration: 1,
                delayOffset: 0.4,
                duplicate: EffectParameters.Duplicate(count: 3, interval: 0.2),
                attachedToTarget: true,
                alphaMax: 0.75,
                fadesOut: true,
                positionXRandomRange: -1.5...1.5,
                positionYRandomRange: -1...1,
                positionStartZRandomRange: 0...2,
                positionEndZRandomRange: 5...7,
                size: [2.5, 100],
                sizeYRandomRange: 30...60
            ),
            .`3D`(
                kind: .texture("effect\\ac_center2.tga"),
                duration: 1,
                duplicate: EffectParameters.Duplicate(count: 10, interval: 0.2),
                attachedToTarget: true,
                alphaMax: 1,
                fadesOut: true,
                positionXRandomRange: -1.5...1.5,
                positionYRandomRange: -1...1,
                positionStartZRandomRange: 0...2,
                positionEndZRandomRange: 5...7,
                size: [2.5, 100],
                sizeYRandomRange: 30...60
            ),
        ],
        "ef_shield_projectile": [
            .`3D`(
                kind: .texture("effect\\shield_boomerang.bmp"),
                duration: 0.14,
                attachedToTarget: true,
                zIndex: 1,
                alphaMax: 1,
                fadesIn: true,
                fadesOut: true,
                movesFromSource: true,
                size: [50, 50],
                angle: 180,
                rotates: true,
                rotationCount: 1,
                rotatesToTarget: true,
                rotatesWithCamera: true
            ),
        ],
        "ef_shieldspell": [
            .wav(soundName: "effect\\lg_shieldspell.wav"),
        ],
        "ef_skynetblow": [
            .wav(soundName: "effect\\sr_skynetblow.wav"),
        ],
        "ef_sound_of_destruction": [
            .wav(soundName: K2L("effect\\사운드오브디스트럭션.wav")),
        ],
        "ef_spear_projectile": [
            .`3D`(
                kind: .sprite(K2L("이팩트\\창"), playSprite: true),
                duration: 0.14,
                attachedToTarget: true,
                zIndex: 1,
                alphaMax: 1,
                fadesIn: true,
                fadesOut: true,
                movesFromSource: true,
                angle: 180,
                rotatesToTarget: true,
                rotatesWithCamera: true
            ),
        ],
        "ef_sr_fallenempire": [
            .str(
                fileName: "new_fallenempire\\new_fallenempire\\new_fallenempire.str",
                soundName: "effect\\sr_fallenempire.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_fallenempire\\new_fallenempire_bottom\\new_fallenempire_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_sr_fallenempire_hit": [
            .str(
                fileName: "new_fallenempire\\new_fallenempire_hit\\new_fallenempire_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_sr_gateofhell_cast": [
            .str(
                fileName: "new_gateofhell\\new_gateofhell_cast\\new_gateofhell_cast.str",
                soundName: "effect\\sr_gateofhell.wav",
                attachedToTarget: false
            ),
        ],
        "ef_sr_howlingoflion": [
            .str(
                fileName: "new_howlingoflion\\new_howlingoflion\\new_howlingoflion.str",
                soundName: "effect\\sr_howlingoflion.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_howlingoflion\\new_howlingoflion_bottom\\new_howlingoflion_bottom.str",
                attachedToTarget: false
            ),
        ],
    ]

    private static let named5: [String : [EffectDefinition]] = [
        "ef_sr_howlingoflion_cast": [
            .str(
                fileName: "new_howlingoflion\\new_howlingoflion_cast\\new_howlingoflion_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_howlingoflion\\new_howlingoflion_cast_bottom\\new_howlingoflion_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_sr_howlingoflion_hit": [
            .str(
                fileName: "new_howlingoflion\\new_howlingoflion_hit\\new_howlingoflion_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_sr_lightningwalk": [
            .str(
                fileName: "lightning.str",
                soundName: "effect\\sr_lightningwalk.wav",
                attachedToTarget: false
            ),
        ],
        "ef_sr_rampageblaster": [
            .str(
                fileName: "new_rampageblaster\\new_rampageblaster\\new_rampageblaster.str",
                soundName: "effect\\sr_rampageblaster.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_rampageblaster\\new_rampageblaster_bottom\\new_rampageblaster_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_sr_tigercannon": [
            .str(
                fileName: "new_tigercannon\\new_tigercannon.str",
                soundName: "effect\\sr_tigercannon.wav",
                attachedToTarget: false
            ),
        ],
        "ef_swing_dance": [
            .wav(soundName: K2L("effect\\스윙댄스.wav")),
            .`3D`(
                kind: .texture("effect\\ac_center2.tga"),
                duration: 1,
                delayLate: 0.5,
                duplicate: EffectParameters.Duplicate(count: 7, interval: 0.2),
                attachedToTarget: true,
                color: [1, 0.1, 0.5],
                alphaMax: 1,
                fadesOut: true,
                positionXRandomRange: -1.5...1.5,
                positionYRandomRange: -1...1,
                positionStartZRandomRange: 0...2,
                positionEndZRandomRange: 5...7,
                size: [2.5, 100],
                sizeYRandomRange: 30...60
            ),
            .`3D`(
                kind: .texture("effect\\ac_center2.tga"),
                duration: 1,
                delayOffset: 0.4,
                duplicate: EffectParameters.Duplicate(count: 3, interval: 0.2),
                attachedToTarget: true,
                alphaMax: 0.75,
                fadesOut: true,
                positionXRandomRange: -1.5...1.5,
                positionYRandomRange: -1...1,
                positionStartZRandomRange: 0...2,
                positionEndZRandomRange: 5...7,
                size: [2.5, 100],
                sizeYRandomRange: 30...60
            ),
            .`3D`(
                kind: .texture("effect\\ac_center2.tga"),
                duration: 1,
                duplicate: EffectParameters.Duplicate(count: 10, interval: 0.2),
                attachedToTarget: true,
                alphaMax: 1,
                fadesOut: true,
                positionXRandomRange: -1.5...1.5,
                positionYRandomRange: -1...1,
                positionStartZRandomRange: 0...2,
                positionEndZRandomRange: 5...7,
                size: [2.5, 100],
                sizeYRandomRange: 30...60
            ),
        ],
        "ef_symphony_of_lovers": [
            .wav(soundName: K2L("effect\\연인들을위한심포니.wav")),
        ],
        "ef_tigercannon": [
            .wav(soundName: "effect\\sr_tigercannon.wav"),
        ],
        "ef_tr_ain_rhapsody": [
            .str(
                fileName: "ain_rhapsody\\ain_rhapsody\\ain_rhapsody.str",
                soundName: "effect\\tr_ain_rhapsody.wav",
                attachedToTarget: false
            ),
        ],
        "ef_tr_ain_rhapsody_cast": [
            .str(
                fileName: "ain_rhapsody\\ain_rhapsody_cast\\ain_rhapsody_cast.str",
                attachedToTarget: false
            ),
        ],
        "ef_tr_gef_nocturn": [
            .str(
                fileName: "gef_nocturn\\gef_nocturn\\gef_nocturn.str",
                soundName: "effect\\tr_gef_nocturn.wav",
                attachedToTarget: false
            ),
        ],
        "ef_tr_gef_nocturn_cast": [
            .str(
                fileName: "gef_nocturn\\gef_nocturn_cast\\gef_nocturn_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "gef_nocturn\\gef_nocturn_cast_bottom\\gef_nocturn_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_tr_jawaii_serenade": [
            .str(
                fileName: "jawaii_serenade\\jawaii_serenade\\jawaii_serenade.str",
                soundName: "effect\\tr_jawaii_serenade.wav",
                attachedToTarget: false
            ),
        ],
        "ef_tr_jawaii_serenade_cast": [
            .str(
                fileName: "jawaii_serenade\\jawaii_serenade_cast\\jawaii_serenade_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "jawaii_serenade\\jawaii_serenade_cast_bottom\\jawaii_serenade_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_tr_kvasir_sonata": [
            .str(
                fileName: "4tr_kvasirsonata\\kvasirsonata\\kvasirsonata.str",
                soundName: "effect\\tr_kvasir_sonata.wav",
                attachedToTarget: false
            ),
        ],
        "ef_tr_kvasir_sonata_cast": [
            .str(
                fileName: "4tr_kvasirsonata\\kvasirsonata_cast\\kvasirsonata_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "4tr_kvasirsonata\\kvasirsonata_cast_bottom\\kvasirsonata_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_tr_metalic_fury": [
            .str(
                fileName: "metalicfury\\metalicfury\\metalicfury.str",
                soundName: "effect\\tr_metalic_fury.wav",
                attachedToTarget: false
            ),
        ],
        "ef_tr_musical_interlude": [
            .str(
                fileName: "musical_interlude\\musical_interlude\\musical_interlude.str",
                soundName: "effect\\tr_musical_interlude.wav",
                attachedToTarget: false
            ),
        ],
        "ef_tr_musical_interlude_cast": [
            .str(
                fileName: "musical_interlude\\musical_interlude_cast\\musical_interlude_cast.str",
                attachedToTarget: false
            ),
        ],
        "ef_tr_mystic_symphony": [
            .str(
                fileName: "mysticsymphony\\mysticsymphony\\mysticsymphony.str",
                soundName: "effect\\tr_mystic_symphony.wav",
                attachedToTarget: false
            ),
        ],
        "ef_tr_mystic_symphony_cast": [
            .str(
                fileName: "mysticsymphony\\mysticsymphony_cast\\mysticsymphony_cast.str",
                attachedToTarget: false
            ),
        ],
        "ef_tr_nipelheim_requiem": [
            .str(
                fileName: "nipelheim\\nipelheim\\nipelheim.str",
                soundName: "effect\\tr_nipelheim_requiem.wav",
                attachedToTarget: false
            ),
        ],
        "ef_tr_nipelheim_requiem_cast": [
            .str(
                fileName: "nipelheim\\nipelheim_cast\\nipelheim_cast.str",
                attachedToTarget: false
            ),
        ],
        "ef_tr_pron_march": [
            .str(
                fileName: "pronmarch\\pronmarch\\pronmarch.str",
                soundName: "effect\\tr_pron_march.wav",
                attachedToTarget: false
            ),
        ],
        "ef_tr_pron_march_cast": [
            .str(
                fileName: "pronmarch\\pronmarch_cast\\pronmarch_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "pronmarch\\pronmarch_cast_bottom\\pronmarch_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_tr_rhythmshooting_cast": [
            .str(
                fileName: "rhythmshooting\\rhythmshooting_cast\\rhythmshooting_cast.str",
                soundName: "effect\\tr_rhythmshooting.wav",
                attachedToTarget: false
            ),
            .str(
                fileName: "rhythmshooting\\rhythmshooting_cast_bottom\\rhythmshooting_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_tr_rhythmshooting_hit": [
            .str(
                fileName: "rhythmshooting\\rhythmshooting_hit\\rhythmshooting_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_tr_roki_capriccio": [
            .str(
                fileName: "roki_capriccio\\roki_capriccio\\roki_capriccio.str",
                soundName: "effect\\tr_roki_capriccio.wav",
                attachedToTarget: false
            ),
        ],
        "ef_tr_roki_capriccio_cast": [
            .str(
                fileName: "roki_capriccio\\roki_capriccio_cast\\roki_capriccio_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "roki_capriccio\\roki_capriccio_cast_bottom\\roki_capriccio_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_tr_roseblossom_atk": [
            .str(
                fileName: "roseblossom\\roseblossom_hit\\roseblossom_hit.str",
                attachedToTarget: false
            ),
        ],
    ]

    private static let named6: [String : [EffectDefinition]] = [
        "ef_tr_roseblossom_cast": [
            .str(
                fileName: "roseblossom\\roseblossom_cast\\roseblossom_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "roseblossom\\roseblossom_cast_bottom\\roseblossom_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_tr_roseblossom_hit": [
            .str(
                fileName: "roseblossom\\roseblossom_hit\\roseblossom_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_tr_soundblend": [
            .str(
                fileName: "soundblend\\soundblend\\soundblend.str",
                attachedToTarget: false
            ),
        ],
        "ef_tr_soundblend_cast": [
            .str(
                fileName: "soundblend\\soundblend_cast\\soundblend_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "soundblend\\soundblend_cast_bottom\\soundblend_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_trample": [
            .wav(soundName: "effect\\lg_trample.wav"),
        ],
        "ef_valley_of_death": [
            .wav(soundName: K2L("effect\\사망의골짜기에서.wav")),
        ],
        "ef_wh_calamitygale_cast": [
            .str(
                fileName: "windhawk\\calamitygale\\calumitygale_cast\\calumitygale_cast.str",
                soundName: "effect\\wh_calamitygale.wav",
                attachedToTarget: false,
                fallbackFileNames: ["4wh_calumitygale\\calumitygale_cast\\calumitygale_cast.str"]
            ),
        ],
        "ef_wh_crescive_bolt": [
            .str(
                fileName: "crescivebolt\\crescivebolt\\crescivebolt.str",
                soundName: "effect\\wh_crescive_bolt.wav",
                attachedToTarget: false
            ),
        ],
        "ef_wh_crescive_bolt_cast": [
            .str(
                fileName: "crescivebolt\\crescivebolt_cast\\crescivebolt_cast.str",
                attachedToTarget: false
            ),
        ],
        "ef_wh_crescive_bolt_hit": [
            .str(
                fileName: "crescivebolt\\crescivebolt_hit\\crescivebolt_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_wh_deepblindtrap": [
            .str(
                fileName: "deepblindtrap\\deepblindtrap\\deepblindtrap.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "deepblindtrap\\deepblindtrap_bottom\\deepblindtrap_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_wh_deepblindtrap_cast": [
            .str(
                fileName: "deepblindtrap\\deepblindtrap_cast\\deepblindtrap_cast.str",
                attachedToTarget: false
            ),
        ],
        "ef_wh_deepblindtrap_hit": [
            .str(
                fileName: "deepblindtrap\\deepblindtrap_hit\\deepblindtrap_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_wh_flametrap": [
            .str(
                fileName: "flametrap\\flametrap\\flametrap.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "flametrap\\flametrap_bottom\\flametrap_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_wh_flametrap_cast": [
            .str(
                fileName: "flametrap\\flametrap_cast\\flametrap_cast.str",
                attachedToTarget: false
            ),
        ],
        "ef_wh_flametrap_hit": [
            .str(
                fileName: "flametrap\\flametrap_hit\\flametrap_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_wh_galestorm": [
            .str(
                fileName: "galestorm\\galestorm\\galestorm.str",
                soundName: "effect\\wh_galestorm.wav",
                attachedToTarget: false
            ),
        ],
        "ef_wh_galestorm_cast": [
            .str(
                fileName: "galestorm\\galestorm_cast\\galestorm_cast.str",
                attachedToTarget: false
            ),
        ],
        "ef_wh_galestorm_hit": [
            .str(
                fileName: "galestorm\\galestorm_hit\\galestorm_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_wh_hawkboomerang": [
            .wav(soundName: "effect\\wh_hawkboomerang.wav"),
        ],
        "ef_wh_hawkrush": [
            .str(
                fileName: "hawkrush\\hawkrush\\hawkrush.str",
                soundName: "effect\\wh_hawkrush.wav",
                attachedToTarget: false
            ),
        ],
        "ef_wh_solidtrap": [
            .str(
                fileName: "solidtrap\\solidtrap\\solidtrap.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "solidtrap\\solidtrap_bottom\\solidtrap_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_wh_solidtrap_cast": [
            .str(
                fileName: "solidtrap\\solidtrap_cast\\solidtrap_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "solidtrap\\solidtrap_cast_bottom\\solidtrap_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_wh_solidtrap_hit": [
            .str(
                fileName: "solidtrap\\solidtrap_hit\\solidtrap_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_wh_swifttrap": [
            .str(
                fileName: "swifttrap\\swifttrap\\swifttrap.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "swifttrap\\swifttrap_bottom\\swifttrap_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_wh_swifttrap_cast": [
            .str(
                fileName: "swifttrap\\swifttrap_cast\\swifttrap_cast.str",
                attachedToTarget: false
            ),
        ],
        "ef_wh_swifttrap_hit": [
            .str(
                fileName: "swifttrap\\swifttrap_hit\\swifttrap_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_wh_wind_sign": [
            .str(
                fileName: "windsign\\windsign\\windsign.str",
                soundName: "effect\\wh_wind_sign.wav",
                attachedToTarget: false
            ),
        ],
        "ef_windmill": [
            .wav(soundName: "effect\\sr_windmill.wav"),
        ],
        "ef_wm_metalicsound": [
            .str(
                fileName: "new_metalicsound\\new_metalicsound\\new_metalicsound.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_metalicsound\\new_metalicsound_bottom\\new_metalicsound_bottom.str",
                attachedToTarget: false
            ),
        ],
    ]

    private static let named7: [String : [EffectDefinition]] = [
        "ef_wm_metalicsound_hit": [
            .str(
                fileName: "new_metalicsound\\new_metalicsound_hit\\new_metalicsound_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_wm_reverberation_magic_hit": [
            .str(
                fileName: "new_reverberation\\new_reverberation_hit\\new_reverberation_hit.str",
                attachedToTarget: false
            ),
        ],
        "ef_wm_severe_rainstorm": [
            .str(
                fileName: "new_severerainstorm\\new_severerainstorm\\new_severerainstorm.str",
                attachedToTarget: false
            ),
        ],
        "ef_wm_severe_rainstorm_cast": [
            .str(
                fileName: "new_severerainstorm\\new_severerainstorm_cast\\new_severerainstorm_cast.str",
                attachedToTarget: false
            ),
        ],
        "ef_wm_severe_rainstorm_melee": [
            .str(
                fileName: "new_severerainstorm\\new_severerainstorm\\new_severerainstorm.str",
                attachedToTarget: false
            ),
        ],
        "ef_wm_severe_rainstorm_melee_cast": [
            .str(
                fileName: "new_severerainstorm\\new_severerainstorm_cast\\new_severerainstorm_cast.str",
                attachedToTarget: false
            ),
        ],
        "ef_wm_sound_of_destruction_cast": [
            .str(
                fileName: "new_soundofdestruction\\new_soundofdestruction_cast\\new_soundofdestruction_cast.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_soundofdestruction\\new_soundofdestruction_cast_bottom\\new_soundofdestruction_cast_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_wm_unlimited_humming_voice": [
            .str(
                fileName: "new_unlimit\\new_unlimit\\new_unlimit.str",
                attachedToTarget: false
            ),
            .str(
                fileName: "new_unlimit\\new_unlimit_bottom\\new_unlimit_bottom.str",
                attachedToTarget: false
            ),
        ],
        "ef_wugbite": [
            .wav(soundName: "wug_bite.wav"),
        ],
        "ef_wugrider": [
            .wav(soundName: "wolf_stand.wav"),
        ],
        "ef_wugstrike": [
            .wav(soundName: "wug_strike.wav"),
        ],
        "enemy_hit_normal1": [
            .wav(soundName: "_enemy_hit_normal1.wav"),
        ],
        "spear_hit_sound": [
            .wav(soundName: "_hit_spear.wav"),
        ],
    ]
}
