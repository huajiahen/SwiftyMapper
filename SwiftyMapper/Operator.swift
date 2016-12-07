//
//  Operator.swift
//  SwiftMapper
//
//  Created by huajiahen on 5/21/16.
//  Copyright © 2016 huajiahen. All rights reserved.
//

infix operator <-: AssignmentPrecedence

public func <-<T: Mappable>(lhs: inout T, rhs: MapFromJSON) {
    if let unwrapped: T = rhs.value() {
        lhs = unwrapped
    }
}

public func <-<T: Mappable>(lhs: inout T?, rhs: MapFromJSON) {
    lhs = rhs.value()
}

public func <-<T: Mappable>(lhs: T?, rhs: MapToJSON) {
    _ = rhs.map(lhs)
}
