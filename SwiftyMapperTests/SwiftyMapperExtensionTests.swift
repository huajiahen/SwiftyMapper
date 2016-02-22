//
//  SwiftyMapperExtensionTests.swift
//  SwiftyMapper
//
//  Created by huajiahen on 2/22/16.
//  Copyright © 2016 huajiahen. All rights reserved.
//

import XCTest
@testable import SwiftyMapper

class SwiftyMapperExtensionTests: XCTestCase {
    func testMapDateFromJSON() {
        let timeStamp = 233
        let JSON = ["timestamp": timeStamp]
        let map = MapFromJSON(JSON: JSON)
        
        let mappedDate: NSDate? = map["timestamp"].value(NSDate.mapFromUnixTimeStamp)
        XCTAssertEqual(mappedDate, NSDate(timeIntervalSince1970: Double(timeStamp)))
    }
    
    func testMapDateToJSON() {
        let timeStamp = 233
        let date = NSDate(timeIntervalSince1970: Double(timeStamp))
        let JSON = ["timestamp": date]
        let map = MapToJSON().map(JSON, mapper: NSDate.mapToUnixTimeStamp)
        let mappedJSON = map.JSON as? [String: Int]
        XCTAssertNotNil(mappedJSON)
        XCTAssertEqual(mappedJSON?["timestamp"], timeStamp)
    }
}