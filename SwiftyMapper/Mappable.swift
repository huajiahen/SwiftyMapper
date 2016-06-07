//
//  Mappable.swift
//  SwiftyMapper
//
//  Created by huajiahen on 2/22/16.
//  Copyright © 2016 huajiahen. All rights reserved.
//

public protocol Serializable {
    func mapToJSON(map: MapToJSON)
}

public protocol Deserializable {
    static func mapFromJSON(map: MapFromJSON) -> Self?
}

public protocol Mappable: Serializable, Deserializable {}

extension Int: Mappable {
    public static func mapFromJSON(map: MapFromJSON) -> Int? {
        return map.JSON as? Int
    }
    
    public func mapToJSON(map: MapToJSON) {
        map.JSON = self
    }
}

extension Float: Mappable {
    public static func mapFromJSON(map: MapFromJSON) -> Float? {
        return map.JSON as? Float
    }
    
    public func mapToJSON(map: MapToJSON) {
        map.JSON = self
    }
}

extension Double: Mappable {
    public static func mapFromJSON(map: MapFromJSON) -> Double? {
        return map.JSON as? Double
    }
    
    public func mapToJSON(map: MapToJSON) {
        map.JSON = self
    }
}

extension Bool: Mappable {
    public static func mapFromJSON(map: MapFromJSON) -> Bool? {
        return map.JSON as? Bool
    }
    
    public func mapToJSON(map: MapToJSON) {
        map.JSON = self
    }
}

extension String: Mappable {
    public static func mapFromJSON(map: MapFromJSON) -> String? {
        return map.JSON as? String
    }
    
    public func mapToJSON(map: MapToJSON) {
        map.JSON = self
    }
}
