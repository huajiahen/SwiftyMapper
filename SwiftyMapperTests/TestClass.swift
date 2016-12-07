//
//  TestClass.swift
//  SwiftyMapper
//
//  Created by huajiahen on 2/20/16.
//  Copyright © 2016 huajiahen. All rights reserved.
//

import SwiftyMapper

class Car {
    
    var type: String
    var name: String?
    
    init() {
        type = "none"
    }
    
    init(map: MapFromJSON) {
        name = map["name"].value()
        type = map["type"].value() ?? "none"
    }
    
    static func configuredCar() -> Car {
        let car = Car()
        car.name = "BMW"
        car.type = "SUV"
        return car
    }
    
    static func failableInit(_ map: MapFromJSON) -> Car? {
        guard !map["name"].isNull && !map["type"].isNull else {
            return nil
        }
        return Car(map: map)
    }
    
    func mapFrom(_ map: MapFromJSON) {
        name = map["name"].value()
        type = map["type"].value() ?? "none"
    }
    
    func mapTo(_ map: MapToJSON) {
        _ = map["name"].map(name)
        _ = map["type"].map(type)
    }
}
