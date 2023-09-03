import Foundation

import Presentation

public func makeSignUpViewModel(name: String? = "any_name",
                         email: String? = "any_email@mail.com",
                         password: String? = "any_password",
                         passwordConfirmation: String? = "any_password") -> SignUpViewModel {
    SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
}

public func makeRequiredAlertViewModel(fieldName: String) -> AlertViewModel {
    AlertViewModel(title: "Falha na validação", message: "O campo \(fieldName) é obrigatorio")
}

public func makeInvalidAlertViewModel(fieldName: String) -> AlertViewModel {
    AlertViewModel(title: "Falha na validação", message: "O campo \(fieldName) é inválido")
}

public func makeErrorAlertViewModel(message: String) -> AlertViewModel {
    return AlertViewModel(title: "Erro", message: message)
}

public func makeSuccessAlertViewModel(message: String) -> AlertViewModel {
    return AlertViewModel(title: "Sucesso", message: message)
}
