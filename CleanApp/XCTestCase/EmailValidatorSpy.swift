import Foundation
import Validation

public class EmailValidatorSpy: EmailValidator {
    var isValid = true
    var email: String?

    public func isValid(email: String) -> Bool {
        self.email = email
        return isValid
    }

    func simulateInvalidEmail() {
        isValid = false
    }
}
