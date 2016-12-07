//
//  MapToJSON.swift
//  SwiftyMapper
//
//  Created by huajiahen on 2/20/16.
//  Copyright © 2016 huajiahen. All rights reserved.
//

public final class MapToJSON {
    
    fileprivate enum ContentType {
        case json(Any)
        case mapArray([MapToJSON])
        case mapDictionary([String: MapToJSON])
        case none
    }
    
    fileprivate var content: ContentType = .none
    public var JSON: Any? {
        get {
            switch content {
            case .json(let JSONContent):
                return JSONContent
            case .mapArray(let mapContent):
                return mapContent.map({ aMap -> Any in aMap.JSON ?? NSNull() })
            case .mapDictionary(let mapContent):
                var JSONDict: [String: Any] = [:]
                for (key, value) in mapContent {
                    JSONDict[key] = value.JSON ?? NSNull()
                }
                return JSONDict
            case .none:
                return nil
            }
        }
        set {
            if newValue == nil {
                content = .none
            } else if newValue is Int || newValue is Float || newValue is Double || newValue is Bool || newValue is String || newValue is [Any] || newValue is [String: Any] || newValue is NSNull {
                content = .json(newValue!)
            }
        }
    }
    
    public func JSONData() throws -> Data? {
        guard JSON != nil else {
            return nil
        }
        return try JSONSerialization.data(withJSONObject: JSON!, options: JSONSerialization.WritingOptions())
    }
    
    public func JSONString(_ prettyPrinted: Bool = true) throws -> String? {
        guard JSON != nil else {
            return nil
        }
        let writingOptions: JSONSerialization.WritingOptions = prettyPrinted ? .prettyPrinted : JSONSerialization.WritingOptions()
        let JSONData = try JSONSerialization.data(withJSONObject: JSON!, options: writingOptions)
        return String(data: JSONData, encoding: String.Encoding.utf8)
    }
    
    //MARK: - Init
    
    public init() {}
    
    //MARK: - Subscript
    
    public subscript(key: String) -> MapToJSON {
        if case .none = content {
            content = .mapDictionary([:])
        }
        
        guard case .mapDictionary(var mapTree) = content  else {
            return MapToJSON()
        }
        
        let newMap = MapToJSON()
        mapTree[key] = newMap
        content = .mapDictionary(mapTree)
        
        return newMap
    }
    
    //MARK: - Map
    
    //MARK: Serializable
    
    public func map<T: Serializable>(_ object: T?) -> MapToJSON {
        if object == nil {
            JSON = nil
        } else {
            object!.mapToJSON(self)
        }
        return self
    }
    
    public func map<T: Serializable>(_ object: [T]?) -> MapToJSON {
        if let mapArray = object?.map({
            MapToJSON().map($0)
        }) {
            content = .mapArray(mapArray)
        } else {
            content = .none
        }
        return self
    }
    
    public func map<T: Serializable>(_ object: [T?]?) -> MapToJSON {
        if let mapArray = object?.map({
            MapToJSON().map($0)
        }) {
            content = .mapArray(mapArray)
        } else {
            content = .none
        }
        return self
    }
    
    public func map<T: Serializable>(_ object: [String: T]?) -> MapToJSON {
        if let mapDict = object?.mapValues({
            MapToJSON().map($0)
        }) {
            content = .mapDictionary(mapDict)
        } else {
            content = .none
        }
        return self
    }
    
    public func map<T: Serializable>(_ object: [String: T?]?) -> MapToJSON {
        if let mapDict = object?.mapValues({
            MapToJSON().map($0)
        }) {
            content = .mapDictionary(mapDict)
        } else {
            content = .none
        }
        return self
    }
    
    //MARK: Object
    
    public func map(_ mapper: ((MapToJSON) -> Void)?) -> MapToJSON {
        if mapper != nil {
            mapper!(self)
        } else {
            content = .none
        }
        return self
    }
    
    public func map<T>(_ object: T?, mapper: (T) -> (MapToJSON) -> Void) -> MapToJSON {
        if object != nil {
            mapper(object!)(self)
        } else {
            content = .none
        }
        return self
    }
    
    public func map<T>(_ object: [T]?, mapper: (T) -> (MapToJSON) -> Void) -> MapToJSON {
        if let mapArray = object?.map({
            MapToJSON().map($0, mapper: mapper)
        }) {
            content = .mapArray(mapArray)
        } else {
            content = .none
        }
        return self
    }
    
    public func map<T>(_ object: [T?]?, mapper: (T) -> (MapToJSON) -> Void) -> MapToJSON {
        if let mapArray = object?.map({
            MapToJSON().map($0, mapper: mapper)
        }) {
            content = .mapArray(mapArray)
        } else {
            content = .none
        }
        return self
    }
    
    public func map<T>(_ object: [String: T]?, mapper: @escaping (T) -> (MapToJSON) -> Void) -> MapToJSON {
        if let mapDict = object?.mapValues({
            MapToJSON().map($0, mapper: mapper)
        }) {
            content = .mapDictionary(mapDict)
        } else {
            content = .none
        }
        return self
    }
    
    public func map<T>(_ object: [String: T?]?, mapper: @escaping (T) -> (MapToJSON) -> Void) -> MapToJSON {
        if let mapDict = object?.mapValues({
            MapToJSON().map($0, mapper: mapper)
        }) {
            content = .mapDictionary(mapDict)
        } else {
            content = .none
        }
        return self
    }
    
}
