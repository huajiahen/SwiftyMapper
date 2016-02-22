//
//  SwiftyMapperFromJSONTests.swift
//  SwiftyMapperTests
//
//  Created by huajiahen on 1/31/16.
//  Copyright © 2016 huajiahen. All rights reserved.
//

import XCTest
@testable import SwiftyMapper


class SwiftyMapperFromJSONTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: Test mapping to JSON and back (basic types: Bool, Int, Double, Float, String)

    func testMappingMappableFromJSON(){
        let boolValue = true
        let intValue = 1
        let floatValue: Float = 1.0
        let doubleValue: Double = 1.0
        let stringValue = "good"
        let JSONString = "{\"bool\": \(boolValue), \"int\": \(intValue), \"float\": \(floatValue), \"double\": \(doubleValue), \"string\": \"\(stringValue)\"}"
        
        let aMap = try? MapFromJSON(JSONString: JSONString)
        
        XCTAssertNotNil(aMap)
        XCTAssertEqual(aMap?["bool"].value(), boolValue)
        XCTAssertEqual(aMap?["int"].value(), intValue)
        XCTAssertEqual(aMap?["float"].value(), floatValue)
        XCTAssertEqual(aMap?["double"].value(), doubleValue)
        XCTAssertEqual(aMap?["string"].value(), stringValue)
    }
    
    func testMappingMappableFromJSON2(){
        let boolValue = true
        let JSONString = "[\(boolValue)]"
        
        let aMap = try? MapFromJSON(JSONString: JSONString)
        
        XCTAssertNotNil(aMap)
        XCTAssertEqual(aMap?[0].value(), boolValue)
    }
    
    func testMappingAnyObjectFromJSON(){
        let value = "STRING"
        let JSONString = "{\"anyObject\" : \"\(value)\"}"
        
        let aMap = try? MapFromJSON(JSONString: JSONString)
        
        XCTAssertNotNil(aMap)
        XCTAssertEqual(aMap?["anyObject"].JSON as? String, value)
    }
    
    // MARK: Test mapping JSON to Arrays or dictionaries of basic types

    func testMappingMappableArrayFromJSON(){
        let value = true
        let JSONString = "{\"arrayBool\" : [\(value)]}"
        
        let aMap = try? MapFromJSON(JSONString: JSONString)
        
        XCTAssertNotNil(aMap)
        let BOOLArray: [Bool]? = aMap!["arrayBool"].value()
        XCTAssertNotNil(BOOLArray)
        XCTAssertEqual(BOOLArray!.first, value)
    }
    
    func testMappingMappableArrayFromJSON2(){
        let value = true
        let JSONString = "{\"arrayBool\" : [\(value), \"good\"]}"
        
        let aMap = try? MapFromJSON(JSONString: JSONString)
        
        XCTAssertNotNil(aMap)
        let BOOLArray: [Bool]? = aMap?["arrayBool"].value()
        XCTAssertNotNil(BOOLArray)
        XCTAssertEqual(BOOLArray?.count, 1)
    }
    
    func testMappingMappableArrayFromJSON3(){
        let value = true
        let JSONString = "{\"arrayBool\" : [\(value), \"good\", null]}"
        
        let aMap = try? MapFromJSON(JSONString: JSONString)
        
        XCTAssertNotNil(aMap)
        let BOOLArray: [Bool?]? = aMap!["arrayBool"].value()
        XCTAssertNotNil(BOOLArray)
        XCTAssertEqual(BOOLArray?[0], value)
        XCTAssertEqual(BOOLArray?[1], nil)
        XCTAssertEqual(BOOLArray?[2], nil)
    }
    
    func testMappingMappableDictionaryFromJSON(){
        let value1 = "hello"
        let value2 = "world"
        let JSONString = "{\"string1\" : \"\(value1)\", \"string2\" : \"\(value2)\"}"
        
        let aMap = try? MapFromJSON(JSONString: JSONString)
        
        XCTAssertNotNil(aMap)
        let dict: [String: String]? = aMap!.value()
        XCTAssertNotNil(dict)
        XCTAssertEqual(dict?["string1"], value1)
        XCTAssertEqual(dict?["string2"], value2)
    }
    
    func testMappingMappableDictionaryFromJSON2(){
        let JSONString = "[\"string1\", \"sth\"]"
        
        let aMap = try? MapFromJSON(JSONString: JSONString)
        
        XCTAssertNotNil(aMap)
        let dict: [String: String]? = aMap!.value()
        XCTAssertNil(dict)
    }
    
    func testMappingMappableDictionaryFromJSON3(){
        let value = "hello"
        let JSONString = "{\"string\" : \"\(value)\", \"bool\" : true}"
        
        let aMap = try? MapFromJSON(JSONString: JSONString)
        
        XCTAssertNotNil(aMap)
        let dict: [String: String]? = aMap!.value()
        XCTAssertNotNil(dict)
        XCTAssertEqual(dict?["string"], value)
        XCTAssertEqual(dict?["bool"], nil)
    }
    
    // MARK: Test mapping JSON to Arrays or dictionaries of basic types
    
    func testMappingNewObjectFromJSON() {
        let name = "BMW"
        let type = "SUV"
        let JSON = ["name": name, "type": type]
        
        let aMap = MapFromJSON(JSON: JSON)
        let car = Car(map: aMap)
        XCTAssertEqual(car.name, name)
        XCTAssertEqual(car.type, type)
    }
    
    func testMappingExistedObjectFromJSON() {
        let name = "BMW"
        let type = "SUV"
        let JSON = ["name": name, "type": type]
        
        let aMap = MapFromJSON(JSON: JSON)
        
        let car = Car()
        car.mapFrom(aMap)
        XCTAssertEqual(car.name, name)
        XCTAssertEqual(car.type, type)
        
    }
    
    func testMappingObjectArrayFromJSON() {
        let name = "BMW"
        let type = "SUV"
        let JSON = [["name": name, "type": type], ["name": name, "type": type]]
        
        let aMap = MapFromJSON(JSON: JSON)
        let carArray: [Car]? = aMap.value(Car.init)
        XCTAssertNotNil(carArray)
        let car = carArray?.first
        XCTAssertNotNil(car)
        XCTAssertEqual(car?.name, name)
        XCTAssertEqual(car?.type, type)
    }
    
    func testMappingObjectArrayFromJSON2() {
        let name = "BMW"
        let type = "SUV"
        let JSON = [["name": name, "type": type], NSNull()]
        
        let aMap = MapFromJSON(JSON: JSON)
        let carArray: [Car?]? = aMap.value(Car.init)
        XCTAssertNotNil(carArray)
        let car = carArray?[0]
        XCTAssertNotNil(car)
        XCTAssertEqual(car?.name, name)
        XCTAssertEqual(car?.type, type)
        XCTAssertNil(carArray?[1])
    }
    
    
    func testMappingOptionalObjectArrayFromJSON() {
        let name = "BMW"
        let type = "SUV"
        let JSON = [["name": name, "type": type], ["name": name], NSNull()]
        
        let aMap = MapFromJSON(JSON: JSON)
        let carArray: [Car?]? = aMap.value(Car.failableInit)
        XCTAssertNotNil(carArray)
        let car = carArray?[0]
        XCTAssertNotNil(car)
        XCTAssertEqual(car?.name, name)
        XCTAssertEqual(car?.type, type)
        XCTAssertNil(carArray?[1])
        XCTAssertNil(carArray?[2])
    }
    
    func testMappingObjectDictionaryFromJSON() {
        let name = "BMW"
        let type = "SUV"
        let JSON = ["car1": ["name": name, "type": type], "car2": ["name": name, "type": type]]
        
        let aMap = MapFromJSON(JSON: JSON)
        let carDict: [String: Car]? = aMap.value(Car.init)
        XCTAssertNotNil(carDict)
        let car = carDict?["car1"]
        XCTAssertEqual(car?.name, name)
        XCTAssertEqual(car?.type, type)
    }
    
    func testMappingOptionalObjectDictionaryFromJSON() {
        let name = "Tokyo"
        let type = "car"
        let JSON = ["car1": ["name": name, "type": type], "car2": ["name": name], "car3": NSNull()]
        
        let aMap = MapFromJSON(JSON: JSON)
        let carDict: [String: Car]? = aMap.value(Car.failableInit)
        XCTAssertNotNil(carDict)

        let car = carDict?["car1"]
        XCTAssertEqual(car?.name, name)
        XCTAssertEqual(car?.type, type)

        XCTAssertNil(carDict?["car2"])
        XCTAssertNil(carDict?["car3"])
    }

}
