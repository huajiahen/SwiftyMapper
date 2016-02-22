//
//  Extension.swift
//  SwiftMapper
//
//  Created by huajiahen on 1/30/16.
//  Copyright © 2016 huajiahen. All rights reserved.
//

import class Foundation.NSDate

extension NSDate {
    public static func mapFromUnixTimeStamp(map: MapFromJSON) -> NSDate? {
        if let timestamp = map.JSON as? Int {
            return NSDate(timeIntervalSince1970: Double(timestamp))
        }
        return nil
    }
    
    public func mapToUnixTimeStamp(map: MapToJSON) {
        let timestamp = Int(timeIntervalSince1970)
        map.JSON = timestamp
    }
}

extension Dictionary {
    func mapValues<T>(transform: Value -> T?) -> [Key: T] {
        var resultDict: [Key: T] = [:]
        for (key, value) in self {
            resultDict[key] = transform(value)
        }
        return resultDict
    }
}