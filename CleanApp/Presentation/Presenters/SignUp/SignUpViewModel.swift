import Foundation
import Domain

public struct SignUpViewModel: Model {
    var name: String?
    var email: String?
    var password: String?
    var passwordConfirmation: String?

    public init(name: String? = nil,
         email: String? = nil,
         password: String? = nil,
         passwordConfirmation: String? = nil) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
    
    public func toAddAccountModel() -> AddAccountModel {
        return AddAccountModel(
            name: name!,
            email: email!,
            password: password!,
            passwordConfirmation: passwordConfirmation!
        )
    }
}
