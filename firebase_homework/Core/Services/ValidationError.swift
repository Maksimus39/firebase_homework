import Foundation



enum ValidationError: LocalizedError {
    case emptyEmail
    case invalidEmail
    case passwordTooShort
    case weakPassword
    
    var errorDescription: String? {
        switch self {
        case .emptyEmail:
            return "Email не может быть пустым"
        case .invalidEmail:
            return "Введите корректный email адрес"
        case .passwordTooShort:
            return "Пароль должен содержать минимум 8 символов"
        case .weakPassword:
            return "Пароль должен содержать буквы и цифры"
        }
    }
}

protocol ValidationServiceProtocol {
    func validate(email: String) -> Result<String, ValidationError>
    func validate(password: String) -> Result<String, ValidationError>
}
