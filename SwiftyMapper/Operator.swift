//
//  Operator.swift
//  SwiftMapper
//
//  Created by huajiahen on 5/21/16.
//  Copyright © 2016 huajiahen. All rights reserved.
//

infix operator <- {associativity left precedence 90}

func <-<T: Mappable>(inout lhs: T, rhs: MapFromJSON) {
    if let unwrapped: T = rhs.value() {
        lhs = unwrapped
    }
}

func <-<T: Mappable>(inout lhs: T?, rhs: MapFromJSON) {
    lhs = rhs.value()
}

func <-<T: Mappable>(lhs: T?, rhs: MapToJSON) {
    rhs.map(lhs)
}
