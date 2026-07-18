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

class ValidationService: ValidationServiceProtocol {
    static let shared = ValidationService()
    
    func validate(email: String) -> Result<String, ValidationError> {
        let trimmed = email.trimmingCharacters(in: .whitespaces)
        
        if trimmed.isEmpty {
            return .failure(.emptyEmail)
        }
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        if !emailPredicate.evaluate(with: trimmed) {
            return .failure(.invalidEmail)
        }
        
        return .success(trimmed)
    }
    
    func validate(password: String) -> Result<String, ValidationError> {
        if password.count < 8 {
            return .failure(.passwordTooShort)
        }
        
        
        let hasLetters = password.range(of: "[a-zA-Z]", options: .regularExpression) != nil
        let hasNumbers = password.range(of: "[0-9]", options: .regularExpression) != nil
        
        if !hasLetters || !hasNumbers {
            return .failure(.weakPassword)
        }
        
        return .success(password)
    }
}
