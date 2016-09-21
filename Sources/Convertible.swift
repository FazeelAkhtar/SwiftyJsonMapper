

public protocol Convertible {
    
    associatedtype ConvertedType = Self

    /**
     `fromMap` returns the expected value based off the provided input
     - parameter value: Any value
     - throws: Any error from your custom implementation (MapperError.convertibleError)
     - returns: The successfully created value from the given input
     
     */
    static func fromMap(_ value: Any) throws -> ConvertedType
}
