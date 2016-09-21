public enum MapperError: Error {
    case convertibleError(value: Any?, type: Any.Type)
    case customError(field: String?, message: String)
    case invalidRawValueError(field: String, value: Any, type: Any.Type)
    case missingFieldError(field: String)
    case typeMismatchError(field: String, value: Any, type: Any.Type)
}
