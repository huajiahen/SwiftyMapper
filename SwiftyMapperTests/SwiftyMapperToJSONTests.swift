//
//  SwiftyMapperToJSONTests.swift
//  SwiftyMapper
//
//  Created by huajiahen on 2/20/16.
//  Copyright © 2016 huajiahen. All rights reserved.
//

import XCTest
@testable import SwiftyMapper

class SwiftyMapperToJSONTests: XCTestCase {
    
    //Mappable
    
    func testMapMappableToJSON() {
        let boolValue = true
        let intValue = 1
        let floatValue: Float = 1.0
        let doubleValue: Double = 1.0
        let stringValue = "good"

        let map = MapToJSON()
        _ = map["bool"].map(boolValue)
        _ = map["int"].map(intValue)
        _ = map["float"].map(floatValue)
        _ = map["double"].map(doubleValue)
        _ = map["string"].map(stringValue)
        _ = map["nil"].map(nil)
        
        let JSON = map.JSON as? [String: Any]
        
        XCTAssertNotNil(JSON)
        XCTAssertEqual(JSON?["bool"] as? Bool, boolValue)
        XCTAssertEqual(JSON?["int"] as? Int, intValue)
        XCTAssertEqual(JSON?["float"] as? Float, floatValue)
        XCTAssertEqual(JSON?["double"] as? Double, doubleValue)
        XCTAssertEqual(JSON?["string"] as? String, stringValue)
        XCTAssertEqual(JSON?["nil"] as? NSNull, NSNull())
    }
    
    func testMapMappableArrayToJSON() {
        let intArray = [1, 2, 3]
        let JSON = MapToJSON().map(intArray).JSON as? [Int]
        XCTAssertEqual(JSON!, intArray)
    }
    
    func testMapOptionalMappableArrayToJSON() {
        let intArray: [Int?] = [1, 2, 3, nil]
        let JSON = MapToJSON().map(intArray).JSON as? [Any]

        XCTAssertNotNil(JSON)
        XCTAssertEqual(JSON?[0] as? Int, 1)
        XCTAssertEqual(JSON?[3] as? NSNull, NSNull())
    }
    
    func testMapMappableDictionaryToJSON() {
        let intDict = ["key1": 1, "key2": 2]
        let JSON = MapToJSON().map(intDict).JSON as? [String: Int]
        XCTAssertEqual(JSON!, intDict)
    }
    
    func testMapOptionalMappableDictionaryToJSON() {
        let intDict: [String: Int?] = ["key1": 1, "key2": nil]
        let JSON = MapToJSON().map(intDict).JSON as? [String: Any]
        XCTAssertNotNil(JSON)

        XCTAssertEqual(JSON?["key1"] as? Int, 1)
        XCTAssertEqual(JSON?["key2"] as? NSNull, NSNull())
    }

    //Object
    
    func testMapObjectToJSONAlternative() {
        let car = Car.configuredCar()
        let JSON = MapToJSON().map(car.mapTo).JSON as? [String: Any]
        XCTAssertNotNil(JSON)

        XCTAssertEqual(JSON?["type"] as? String, car.type)
        XCTAssertEqual(JSON?["name"] as? String, car.name)
    }
    
    func testMapObjectToJSONAlternative2() {
        let car: Car? = nil
        let JSON = MapToJSON().map(car?.mapTo).JSON as? [String: Any]
        XCTAssertNil(JSON)
    }
    
    func testMapObjectToJSON() {
        let car = Car.configuredCar()
        let JSON = MapToJSON().map(car, mapper: Car.mapTo).JSON as? [String: Any]
        XCTAssertNotNil(JSON)
        
        XCTAssertEqual(JSON?["type"] as? String, car.type)
        XCTAssertEqual(JSON?["name"] as? String, car.name)
    }
    
    
    func testMapObjectToJSON2() {
        let car: Car? = nil
        let JSON = MapToJSON().map(car, mapper: Car.mapTo).JSON
        XCTAssertNil(JSON)
    }
    
    func testMapObjectArrayToJSON() {
        let car = Car.configuredCar()
        let carArray = [car]
        let JSON = MapToJSON().map(carArray, mapper: Car.mapTo).JSON as? [[String: Any]]

        XCTAssertNotNil(JSON)
        
        XCTAssertEqual(JSON?[0]["type"] as? String, car.type)
        XCTAssertEqual(JSON?[0]["name"] as? String, car.name)
    }
    
    func testMapObjectArrayToJSON2() {
        let carArray: [Car]? = nil
        let JSON = MapToJSON().map(carArray, mapper: Car.mapTo).JSON
        XCTAssertNil(JSON)
    }

    
    func testMapOptionalObjectArrayToJSON() {
        let car = Car.configuredCar()
        let carArray: [Car?] = [car, nil]
        let JSON = MapToJSON().map(carArray, mapper: Car.mapTo).JSON as? [Any]
        
        XCTAssertNotNil(JSON)
        
        let carJSON = JSON?[0] as? [String: AnyObject]
        XCTAssertNotNil(carJSON)
        XCTAssertEqual(carJSON?["type"] as? String, car.type)
        XCTAssertEqual(carJSON?["name"] as? String, car.name)
        XCTAssertEqual(JSON?[1] as? NSNull, NSNull())
    }
    
    func testMapOptionalObjectArrayToJSON2() {
        let carArray: [Car]? = nil
        let JSON = MapToJSON().map(carArray, mapper: Car.mapTo).JSON
        XCTAssertNil(JSON)
    }
    
    func testMapObjectDictionaryToJSON() {
        let car = Car.configuredCar()
        let carDict = ["car": car]
        let JSON = MapToJSON().map(carDict, mapper: Car.mapTo).JSON as? [String: [String: Any]]
        
        XCTAssertNotNil(JSON)
        
        XCTAssertEqual(JSON?["car"]?["type"] as? String, car.type)
        XCTAssertEqual(JSON?["car"]?["name"] as? String, car.name)
    }
    
    func testMapObjectDictionaryToJSON2() {
        let carDict: [String: Car]? = nil
        let JSON = MapToJSON().map(carDict, mapper: Car.mapTo).JSON
        XCTAssertNil(JSON)
    }
    
    func testMapOptionalObjectDictionaryToJSON() {
        let car = Car.configuredCar()
        let carDict: [String: Car?] = ["car": car, "nil": nil]
        let JSON = MapToJSON().map(carDict, mapper: Car.mapTo).JSON as? [String: Any]
        
        XCTAssertNotNil(JSON)
        
        let carJSON = JSON?["car"] as? [String: Any]
        XCTAssertNotNil(carJSON)
        XCTAssertEqual(carJSON?["type"] as? String, car.type)
        XCTAssertEqual(carJSON?["name"] as? String, car.name)
        XCTAssertEqual(JSON?["nil"] as? NSNull, NSNull())
    }
    
    func testMapOptionalObjectDictionaryToJSON2() {
        let carDict: [String: Car?]? = nil
        let JSON = MapToJSON().map(carDict, mapper: Car.mapTo).JSON
        XCTAssertNil(JSON)
    }
}

