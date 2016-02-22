//
//  MapToJSON.swift
//  SwiftyMapper
//
//  Created by huajiahen on 2/20/16.
//  Copyright © 2016 huajiahen. All rights reserved.
//

public final class MapToJSON {
    
    private enum ContentType {
        case JSON(AnyObject)
        case MapArray([MapToJSON])
        case MapDictionary([String: MapToJSON])
        case None
    }
    
    private var content: ContentType = .None
    var JSON: AnyObject? {
        get {
            switch content {
            case .JSON(let JSONContent):
                return JSONContent
            case .MapArray(let mapContent):
                return mapContent.map({ aMap -> AnyObject in aMap.JSON ?? NSNull() })
            case .MapDictionary(let mapContent):
                var JSONDict: [String: AnyObject] = [:]
                for (key, value) in mapContent {
                    JSONDict[key] = value.JSON ?? NSNull()
                }
                return JSONDict
            case .None:
                return nil
            }
        }
        set {
            if newValue == nil {
                content = .None
            } else if newValue is Int || newValue is Float || newValue is Bool || newValue is String || newValue is [AnyObject] || newValue is [String: AnyObject] || newValue is NSNull {
                content = .JSON(newValue!)
            }
        }
    }
    
    func JSONData() throws -> NSData? {
        guard JSON != nil else {
            return nil
        }
        return try NSJSONSerialization.dataWithJSONObject(JSON!, options: NSJSONWritingOptions())
    }
    
    func JSONString(prettyPrinted: Bool = true) throws -> String? {
        guard JSON != nil else {
            return nil
        }
        let writingOptions: NSJSONWritingOptions = prettyPrinted ? .PrettyPrinted : NSJSONWritingOptions()
        let JSONData = try NSJSONSerialization.dataWithJSONObject(JSON!, options: writingOptions)
        return String(data: JSONData, encoding: NSUTF8StringEncoding)
    }
    
    //MARK: - Subscript
    
    public subscript(key: String) -> MapToJSON {
        if case .None = content {
            content = .MapDictionary([:])
        }
        
        guard case .MapDictionary(var mapTree) = content  else {
            return MapToJSON()
        }
        
        let newMap = MapToJSON()
        mapTree[key] = newMap
        content = .MapDictionary(mapTree)
        
        return newMap
    }
    
    //MARK: - Map
    
    //MARK: Mappable
    
    public func map<T: Mappable>(object: T?) -> MapToJSON {
        if object == nil {
            JSON = nil
        } else {
            object!.mapToJSON(self)
        }
        return self
    }
    
    public func map<T: Mappable>(object: [T]?) -> MapToJSON {
        if let mapArray = object?.map({
            MapToJSON().map($0)
        }) {
            content = .MapArray(mapArray)
        } else {
            content = .None
        }
        return self
    }
    
    public func map<T: Mappable>(object: [T?]?) -> MapToJSON {
        if let mapArray = object?.map({
            MapToJSON().map($0)
        }) {
            content = .MapArray(mapArray)
        } else {
            content = .None
        }
        return self
    }
    
    public func map<T: Mappable>(object: [String: T]?) -> MapToJSON {
        if let mapDict = object?.mapValues({
            MapToJSON().map($0)
        }) {
            content = .MapDictionary(mapDict)
        } else {
            content = .None
        }
        return self
    }
    
    public func map<T: Mappable>(object: [String: T?]?) -> MapToJSON {
        if let mapDict = object?.mapValues({
            MapToJSON().map($0)
        }) {
            content = .MapDictionary(mapDict)
        } else {
            content = .None
        }
        return self
    }
    
    //MARK: Object
    
    public func map(mapper: (MapToJSON -> Void)?) -> MapToJSON {
        if mapper != nil {
            mapper!(self)
        } else {
            content = .None
        }
        return self
    }
    
    public func map<T>(object: T?, mapper: T -> MapToJSON -> Void) -> MapToJSON {
        if object != nil {
            mapper(object!)(self)
        } else {
            content = .None
        }
        return self
    }
    
    public func map<T>(object: [T]?, mapper: T -> MapToJSON -> Void) -> MapToJSON {
        if let mapArray = object?.map({
            MapToJSON().map($0, mapper: mapper)
        }) {
            content = .MapArray(mapArray)
        } else {
            content = .None
        }
        return self
    }
    
    public func map<T>(object: [T?]?, mapper: T -> MapToJSON -> Void) -> MapToJSON {
        if let mapArray = object?.map({
            MapToJSON().map($0, mapper: mapper)
        }) {
            content = .MapArray(mapArray)
        } else {
            content = .None
        }
        return self
    }
    
    public func map<T>(object: [String: T]?, mapper: T -> MapToJSON -> Void) -> MapToJSON {
        if let mapDict = object?.mapValues({
            MapToJSON().map($0, mapper: mapper)
        }) {
            content = .MapDictionary(mapDict)
        } else {
            content = .None
        }
        return self
    }
    
    public func map<T>(object: [String: T?]?, mapper: T -> MapToJSON -> Void) -> MapToJSON {
        if let mapDict = object?.mapValues({
            MapToJSON().map($0, mapper: mapper)
        }) {
            content = .MapDictionary(mapDict)
        } else {
            content = .None
        }
        return self
    }
    
}
