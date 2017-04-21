import Foundation

/**
 Mapper creates strongly typed objects from a given NSDictionary based on the mapping provided by implementing
 the Mappable protocol (see `Mappable` for an example).
 */
public struct Mapper {
    public let JSON: NSDictionary

    public init(JSON: NSDictionary) {
        self.JSON = JSON
    }

    
    /**
     Map From Generic Value
     */
    

    public func from<T: RawRepresentable>(_ field: String) throws -> T {
        let object = try self.JSONFromField(field)
        guard let rawValue = object as? T.RawValue else {
            throw MapperError.typeMismatchError(field: field, value: object, type: T.RawValue.self)
        }

        guard let value = T(rawValue: rawValue) else {
            throw MapperError.invalidRawValueError(field: field, value: rawValue, type: T.self)
        }

        return value
    }

    
    /**
     Map From optional Generic Value
     */
    
    public func optionalFrom<T: RawRepresentable>(_ field: String) -> T? {
        return try? self.from(field)
    }


    /**
     Map From Generic Values as Array
     */
    
    
    public func optionalFrom<T: RawRepresentable>(_ fields: [String]) -> T? {
        for field in fields {
            if let value: T = try? self.from(field) {
                return value
            }
        }

        return nil
    }


    /**
        Map From Generic Value and Field Name
     */
    
    public func from<T: RawRepresentable>(_ field: String, defaultValue: T? = nil) throws ->
        [T] where T.RawValue: Convertible, T.RawValue == T.RawValue.ConvertedType
    {
        let value = try self.JSONFromField(field)
        guard let array = value as? [Any] else {
            throw MapperError.typeMismatchError(field: field, value: value, type: [Any].self)
        }

        let rawValues = try array.map { try T.RawValue.fromMap($0) }
        return rawValues.flatMap { T(rawValue: $0) ?? defaultValue }
    }



    /**
     Map From Generic Field name
     */
    
    public func from<T: Mappable>(_ field: String) throws -> T {
        let value = try self.JSONFromField(field)
        if let JSON = value as? NSDictionary {
            return try T(map: Mapper(JSON: JSON))
        }

        throw MapperError.typeMismatchError(field: field, value: value, type: NSDictionary.self)
    }


    /**
     Map From Generic Value FieldName into Array of Generic
     */
    
    
    
    public func from<T: Mappable>(_ field: String) throws -> [T] {
        let value = try self.JSONFromField(field)
        if let JSON = value as? [NSDictionary] {
            return try JSON.map { try T(map: Mapper(JSON: $0)) }
        }

        throw MapperError.typeMismatchError(field: field, value: value, type: [NSDictionary].self)
    }


    public func optionalFrom<T: Mappable>(_ field: String) -> T? {
        return try? self.from(field)
    }


    public func optionalFrom<T: Mappable>(_ field: String) -> [T]? {
        return try? self.from(field)
    }


    public func optionalFrom<T: Mappable>(_ fields: [String]) -> T? {
        for field in fields {
            if let value: T = try? self.from(field) {
                return value
            }
        }

        return nil
    }


    public func from<T: Convertible>(_ field: String) throws -> T where T == T.ConvertedType {
        return try self.from(field, transformation: T.fromMap)
    }

    public func from<T: Convertible>(_ field: String) throws -> T? where T == T.ConvertedType {
        return try self.from(field, transformation: T.fromMap)
    }

    public func from<T: Convertible>(_ field: String) throws -> [T] where T == T.ConvertedType {
        let value = try self.JSONFromField(field)
        if let JSON = value as? [Any] {
            return try JSON.map(T.fromMap)
        }

        throw MapperError.typeMismatchError(field: field, value: value, type: [Any].self)
    }

    public func optionalFrom<T: Convertible>(_ field: String) -> T? where T == T.ConvertedType {
        return try? self.from(field, transformation: T.fromMap)
    }

    public func optionalFrom<T: Convertible>(_ field: String) -> [T]? where T == T.ConvertedType {
        return try? self.from(field)
    }

    public func from<U: Convertible, T: Convertible>(_ field: String) throws -> [U: T]
        where U == U.ConvertedType, T == T.ConvertedType
    {
        let object = try self.JSONFromField(field)
        guard let data = object as? [AnyHashable: Any] else {
            throw MapperError.typeMismatchError(field: field, value: object, type: [AnyHashable: Any].self)
        }

        var result = [U: T]()
        for (key, value) in data {
            result[try U.fromMap(key)] = try T.fromMap(value)
        }

        return result
    }

    public func optionalFrom<U: Convertible, T: Convertible>(_ field: String) -> [U: T]?
        where U == U.ConvertedType, T == T.ConvertedType
    {
        return try? self.from(field)
    }

    public func optionalFrom<T: Convertible>(_ fields: [String]) -> T? where T == T.ConvertedType {
        for field in fields {
            if let value: T = try? self.from(field) {
                return value
            }
        }

        return nil
    }

    public func from<T>(_ field: String, transformation: (Any) throws -> T) throws -> T {
        return try transformation(try self.JSONFromField(field))
    }

    public func optionalFrom<T>(_ field: String, transformation: (Any) throws -> T?) -> T? {
        return (try? transformation(try? self.JSONFromField(field))).flatMap { $0 }
    }

    private func JSONFromField(_ field: String) throws -> Any {
        if let value = field.isEmpty ? self.JSON : self.JSON.safeValue(forKeyPath: field) {
            return value
        }

        throw MapperError.missingFieldError(field: field)
    }
}
