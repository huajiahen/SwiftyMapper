//
//  MapFromJSON.swift
//  SwiftMapper
//
//  Created by huajiahen on 1/30/16.
//  Copyright © 2016 huajiahen. All rights reserved.
//

import class Foundation.NSNull
import class Foundation.NSData
import class Foundation.NSJSONSerialization
import var Foundation.NSUTF8StringEncoding

public final class MapFromJSON {
    
    public enum MapFromJSONError: ErrorType {
        case InvalidJSONString
    }
    
    public let JSON: AnyObject?
    public var isNull: Bool {
        return JSON == nil || JSON is NSNull
    }
    
    var JSONArray: [AnyObject]? {
        return JSON as? [AnyObject]
    }
    
    var JSONDictionary: [String: AnyObject]? {
        return JSON as? [String: AnyObject]
    }
    
    //MARK: Deserializable
    
    public func value<T: Deserializable>() -> T? {
        return T.mapFromJSON(self)
    }
    
    public func value<T: Deserializable>() -> [T]? {
        return JSONArray?.flatMap{
            T.mapFromJSON(MapFromJSON(JSON: $0))
        }
    }
    
    public func value<T: Deserializable>() -> [T?]? {
        return JSONArray?.map{
            T.mapFromJSON(MapFromJSON(JSON: $0))
        }
    }
    
    public func value<T: Deserializable>() -> [String: T]? {
        return JSONDictionary?.mapValues({
            T.mapFromJSON(MapFromJSON(JSON: $0))
        })
    }
    
    //MARK: Object
    
    public func value<T>(mapper: MapFromJSON -> T) -> T {
        return mapper(MapFromJSON(JSON: JSON))
    }

    public func value<T>(mapper: MapFromJSON -> T?) -> T? {
        return mapper(MapFromJSON(JSON: JSON))
    }
    
    //MARK: Obejct array
    
    public func value<T>(mapper: MapFromJSON -> T) -> [T]? {
        return JSONArray?.flatMap{ object -> T? in
            if object is NSNull {
                return nil
            }
            return mapper(MapFromJSON(JSON: object))
        }
    }
    
    public func value<T>(mapper: MapFromJSON -> T?) -> [T]? {
        return JSONArray?.flatMap{ object -> T? in
            if object is NSNull {
                return nil
            }
            return mapper(MapFromJSON(JSON: object))
        }
    }
    
    public func value<T>(mapper: MapFromJSON -> T) -> [T?]? {
        return JSONArray?.map{ object -> T? in
            if object is NSNull {
                return nil
            }
            return mapper(MapFromJSON(JSON: object))
        }
    }
    
    public func value<T>(mapper: MapFromJSON -> T?) -> [T?]? {
        return JSONArray?.map{ object -> T? in
            if object is NSNull {
                return nil
            }
            return mapper(MapFromJSON(JSON: object))
        }
    }
    
    //MARK: Obejct Dictionary
    
    public func value<T>(mapper: MapFromJSON -> T) -> [String: T]? {
        return JSONDictionary?.mapValues({ object -> T? in
            if object is NSNull {
                return nil
            }
            return mapper(MapFromJSON(JSON: object))
        })
    }
    
    public func value<T>(mapper: MapFromJSON -> T?) -> [String: T]? {
        return JSONDictionary?.mapValues({ object -> T? in
            if object is NSNull {
                return nil
            }
            return mapper(MapFromJSON(JSON: object))
        })
    }
    
    //MARK: - Init
    
    public init(JSON: AnyObject?) {
        if JSON is Int || JSON is Float || JSON is Bool || JSON is String || JSON is [AnyObject] || JSON is [String: AnyObject] {
            self.JSON = JSON
        } else {
            self.JSON = nil
        }
    }
    
    public convenience init(JSONData: NSData) throws {
        let JSON = try NSJSONSerialization.JSONObjectWithData(JSONData, options: .AllowFragments)
        self.init(JSON: JSON)
    }
    
    public convenience init(JSONString: String) throws {
        guard let data = JSONString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true) else {
            throw MapFromJSONError.InvalidJSONString
        }
        try self.init(JSONData: data)
    }
    
    //MARK: - Subscript
    
    public subscript(key: String) -> MapFromJSON {
        return MapFromJSON(JSON: JSONDictionary?[key])
    }
    
    public subscript(key: Int) -> MapFromJSON {
        guard let JSONArray = JSONArray where JSONArray.indices ~= key else {
            return MapFromJSON(JSON: nil)
        }
        return MapFromJSON(JSON: JSONArray[key])
    }
}
