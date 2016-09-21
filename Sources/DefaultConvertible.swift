/**
 The DefaultConvertible protocol defines values that can be converted from JSON by conditionally downcasting
*/

import Foundation

public protocol DefaultConvertible: Convertible {}


//Default Extention

extension DefaultConvertible {
    public static func fromMap(_ value: Any) throws -> ConvertedType {
        if let object = value as? ConvertedType {
            return object
        }
        throw MapperError.convertibleError(value: value, type: ConvertedType.self)
    }
}



/// Mapper for default conformances 

extension NSDictionary:     DefaultConvertible {}
extension NSArray:          DefaultConvertible {}
extension String:           DefaultConvertible {}
extension Int:              DefaultConvertible {}
extension UInt:             DefaultConvertible {}
extension Float:            DefaultConvertible {}
extension Double:           DefaultConvertible {}
extension Bool:             DefaultConvertible {}
