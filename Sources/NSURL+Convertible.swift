import Foundation

/**
 URL Convertible implementation
 */
extension URL: Convertible {

    
    public static func fromMap(_ value: Any) throws -> URL {
        guard let string = value as? String else {
            throw MapperError.convertibleError(value: value, type: String.self)
        }

        if let URL = URL(string: string) {
            return URL
        }

        throw MapperError.customError(field: nil, message: "'\(string)' is not a valid URL")
    }
}
