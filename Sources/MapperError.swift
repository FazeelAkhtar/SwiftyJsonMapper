

/*
 
 MapperErrors : Enum of Mapper Errors
 
 */
public enum MapperError: Error {
    
    //Mismatch Error
    case typeMismatchError(field: String, value: Any, type: Any.Type)
    //invalid type Error
    case invalidRawValueError(field: String, value: Any, type: Any.Type)
    //Custom kind  Error
    case customError(field: String?, message: String)
   //Missing type Error
    case missingFieldError(field: String)
    //Convertible type Error
    case convertibleError(value: Any?, type: Any.Type)

}
