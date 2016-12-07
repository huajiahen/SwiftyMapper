//
//  Extension.swift
//  SwiftMapper
//
//  Created by huajiahen on 1/30/16.
//  Copyright © 2016 huajiahen. All rights reserved.
//

import class Foundation.NSDate

extension Date {
    public static func mapFromUnixTimeStamp(_ map: MapFromJSON) -> Date? {
        if let timestamp = map.JSON as? Int {
            return Date(timeIntervalSince1970: TimeInterval(timestamp))
        }
        return nil
    }
    
    public func mapToUnixTimeStamp(_ map: MapToJSON) {
        let timestamp = Int(timeIntervalSince1970)
        map.JSON = timestamp
    }
}

extension Dictionary {
    func mapValues<T>(_ transform: (Value) -> T?) -> [Key: T] {
        var resultDict: [Key: T] = [:]
        for (key, value) in self {
            resultDict[key] = transform(value)
        }
        return resultDict
    }
}
