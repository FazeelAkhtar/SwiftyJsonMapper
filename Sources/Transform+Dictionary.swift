import Foundation

// Transform to dictionary

public extension Transform {
    public static func toDictionary<T, U>(key getKey: @escaping (T) -> U) ->
        (_ object: Any) throws -> [U: T] where T: Mappable, U: Hashable
    {
        return { object in
            guard let objects = object as? [NSDictionary] else {
                throw MapperError.convertibleError(value: object, type: [NSDictionary].self)
            }

            var dictionary: [U: T] = [:]
            for object in objects {
                let model = try T(map: Mapper(JSON: object))
                dictionary[getKey(model)] = model
            }

            return dictionary
        }
    }
}
