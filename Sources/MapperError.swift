

/*
 
 MapperErrors : Enum of Mapper Errors
 
 */
public enum MapperError: Error {
    
    
    case typeMismatchError(field: String, value: Any, type: Any.Type)
    
    case invalidRawValueError(field: String, value: Any, type: Any.Type)
    
    case customError(field: String?, message: String)
   
    case missingFieldError(field: String)
    
    case convertibleError(value: Any?, type: Any.Type)

}
