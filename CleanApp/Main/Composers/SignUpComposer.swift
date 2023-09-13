import Foundation
import UI
import Presentation
import Validation
import Domain

public final class SignUpComposer {
    static func composeControllerWith(addAccount: AddAccount) -> SignUpViewController {
        let controller = SignUpViewController.instanciate()
        let validationComposite = ValidationComposite(validations: makeValidations())
        let presenter = SignUpPresenter(
            alertView: WeakVarProxy(controller),
            addAccount: addAccount, 
            loadingView: WeakVarProxy(controller), 
            validation: validationComposite
        )
        controller.signUp = presenter.signUp
        
        return controller
    }
    
    public static func makeValidations() -> [Validation] {
        return [
            RequiredFieldValidation(fieldName: "name", fiedlLabel: "Nome"),
            RequiredFieldValidation(fieldName: "email", fiedlLabel: "Email"),
            EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorAdapter()),
            RequiredFieldValidation(fieldName: "password", fiedlLabel: "Senha"),
            RequiredFieldValidation(fieldName: "passwordConfirmation", fiedlLabel: "Confirmar Senha"),
            CompareFieldsValidation(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fiedlLabel: "Confirmar Senha"),
        ]
    }
}
