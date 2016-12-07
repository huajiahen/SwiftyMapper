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
        
        let mappedDate: Date? = map["timestamp"].value(Date.mapFromUnixTimeStamp)
        XCTAssertEqual(mappedDate, Date(timeIntervalSince1970: Double(timeStamp)))
    }
    
    func testMapDateToJSON() {
        let timeStamp = 233
        let date = Date(timeIntervalSince1970: Double(timeStamp))
        let JSON = ["timestamp": date]
        let map = MapToJSON().map(JSON, mapper: Date.mapToUnixTimeStamp)
        let mappedJSON = map.JSON as? [String: Int]
        XCTAssertNotNil(mappedJSON)
        XCTAssertEqual(mappedJSON?["timestamp"], timeStamp)
    }
}
