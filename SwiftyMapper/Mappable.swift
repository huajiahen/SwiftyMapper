//
//  Mappable.swift
//  SwiftyMapper
//
//  Created by huajiahen on 2/22/16.
//  Copyright © 2016 huajiahen. All rights reserved.
//

public protocol Serializable {
    func mapToJSON(_ map: MapToJSON)
}

public protocol Deserializable {
    static func mapFromJSON(_ map: MapFromJSON) -> Self?
}

public protocol Mappable: Serializable, Deserializable {}

extension Int: Mappable {
    public static func mapFromJSON(_ map: MapFromJSON) -> Int? {
        return map.JSON as? Int
    }
    
    public func mapToJSON(_ map: MapToJSON) {
        map.JSON = self
    }
}

extension Float: Mappable {
    public static func mapFromJSON(_ map: MapFromJSON) -> Float? {
        return map.JSON as? Float
    }
    
    public func mapToJSON(_ map: MapToJSON) {
        map.JSON = self
    }
}

extension Double: Mappable {
    public static func mapFromJSON(_ map: MapFromJSON) -> Double? {
        return map.JSON as? Double
    }
    
    public func mapToJSON(_ map: MapToJSON) {
        map.JSON = self
    }
}

extension Bool: Mappable {
    public static func mapFromJSON(_ map: MapFromJSON) -> Bool? {
        return map.JSON as? Bool
    }
    
    public func mapToJSON(_ map: MapToJSON) {
        map.JSON = self
    }
}

extension String: Mappable {
    public static func mapFromJSON(_ map: MapFromJSON) -> String? {
        return map.JSON as? String
    }
    
    public func mapToJSON(_ map: MapToJSON) {
        map.JSON = self
    }
}
