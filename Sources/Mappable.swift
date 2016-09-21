import Foundation

/**
 The Mappable protocol defines how to create a custom object from a Mapper
 */

public protocol Mappable {

    init(map: Mapper) throws
}

public extension Mappable {
    /**
     Convenience method for creating Mappable objects from NSDictionaries
     */
    public static func from(_ JSON: NSDictionary) -> Self? {
        return try? self.init(map: Mapper(JSON: JSON))
    }

    /**
     Convenience method for creating Mappable objects from a NSArray
     */
    public static func from(_ JSON: NSArray) -> [Self]? {
        if let array = JSON as? [NSDictionary] {
            return try? array.map { try self.init(map: Mapper(JSON: $0)) }
        }

        return nil
    }
}
