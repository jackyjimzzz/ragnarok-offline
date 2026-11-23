//
//  SpriteConfiguration+MapObject.swift
//  RagnarokGame
//
//  Created by Leon Li on 2026/8/23.
//

import RagnarokSprite

extension ComposedSprite.Configuration {
    init(object: MapSceneMapObject) {
        // [RagOff iPad Mod] Draw mounts and the falcon from the effect state bits.
        self.init(jobID: Self.ragOffMountedJobID(job: object.job, effectState: object.effectStateRaw))
        self.ragOffFalcon = Self.ragOffFalconKind(job: object.job, effectState: object.effectStateRaw)
        self.gender = object.gender
        self.hairStyle = object.hairStyle
        self.hairColor = object.hairColor
        self.clothesColor = object.clothesColor
        self.weapon = object.weaponType.rawValue
        self.shield = object.shield
        self.headgears = [object.headTop, object.headMid, object.headBottom]
        self.garment = object.garment

        self.updateHairStyle()
    }
}

// MARK: - [RagOff iPad Mod] Mounts and falcon

extension ComposedSprite.Configuration {
    private static let ragOffFalconBit = 0x10
    private static let ragOffRidingBit = 0x20
    private static let ragOffDragonBits = 0x80000 | 0x800000 | 0x1000000 | 0x2000000 | 0x4000000
    private static let ragOffWugRiderBit = 0x200000
    private static let ragOffMadoGearBit = 0x400000

    /// Peco Peco, dragon and gryphon riders.
    private static let ragOffRidingJobs: [Int : Int] = [
        7: 13,          // Knight
        14: 21,         // Crusader
        4008: 4014,     // Lord Knight
        4015: 4022,     // Paladin
        4030: 4036,     // Baby Knight
        4037: 4044,     // Baby Crusader
        4054: 4080,     // Rune Knight
        4060: 4081,     // Rune Knight (Trans)
        4066: 4082,     // Royal Guard
        4073: 4083,     // Royal Guard (Trans)
        4096: 4109,     // Baby Rune Knight
        4102: 4110,     // Baby Royal Guard
        4252: 4280,     // Dragon Knight
        4258: 4281,     // Imperial Guard
    ]

    /// Warg riders.
    private static let ragOffWugRiderJobs: [Int : Int] = [
        4056: 4084,     // Ranger
        4062: 4085,     // Ranger (Trans)
        4098: 4111,     // Baby Ranger
        4257: 4278,     // Windhawk
    ]

    /// Mado Gear pilots.
    private static let ragOffMadoGearJobs: [Int : Int] = [
        4058: 4086,     // Mechanic
        4064: 4087,     // Mechanic (Trans)
        4100: 4112,     // Baby Mechanic
        4253: 4279,     // Meister
    ]

    static func ragOffMountedJobID(job: Int, effectState: Int) -> Int {
        if effectState & (ragOffRidingBit | ragOffDragonBits) != 0, let mounted = ragOffRidingJobs[job] {
            return mounted
        }
        if effectState & ragOffWugRiderBit != 0, let mounted = ragOffWugRiderJobs[job] {
            return mounted
        }
        if effectState & ragOffMadoGearBit != 0, let mounted = ragOffMadoGearJobs[job] {
            return mounted
        }
        return job
    }

    static func ragOffFalconKind(job: Int, effectState: Int) -> Int {
        guard effectState & ragOffFalconBit != 0 else {
            return 0
        }
        switch job {
        case 4012:
            return 2    // Sniper
        case 4056, 4062, 4098, 4084, 4085, 4111:
            return 3    // Ranger
        case 4257, 4270, 4278:
            return 4    // Windhawk
        default:
            return 1    // Hunter
        }
    }
}
