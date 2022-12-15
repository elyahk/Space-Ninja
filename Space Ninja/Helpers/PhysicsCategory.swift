//
//  File.swift
//  Space Ninja
//
//  Created by eldorbek nusratov on 12/14/22.
//

import Foundation

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let kyo: UInt32 = 0x1 << 1
    static let shadow: UInt32 = 0x1 << 2
    static let mice: UInt32 = 0x1 << 3
    static let ground: UInt32 = 0x1 << 4
    static let shuriken: UInt32 = 0x1 << 5
}
