//
//  File.swift
//  Space Ninja
//
//  Created by eldorbek nusratov on 12/14/22.
//

import Foundation

extension CGPoint {
    static func +(_ lhs: CGPoint, _ rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}
