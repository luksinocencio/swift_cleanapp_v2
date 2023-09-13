import XCTest
@testable import Presentation
@testable import Validation

final class EmailValidationTests: XCTestCase {
    func test_validate_should_return_error_if_invalid_email_is_provided() {
        let emailValidatiorSpy = EmailValidatorSpy()
        let sut = makeSut(
            fieldName: "email",
            fieldLabel: "Email",
            emailValidator: emailValidatiorSpy
        )
        emailValidatiorSpy.simulateInvalidEmail()
        let errorMessage = sut.validate(data: ["email": "invalid_email@mail.com"])
        XCTAssertEqual(errorMessage, "O campo Email é inválido")
    }
    
    func test_validate_should_return_error_with_correct_fieldLabel() {
        let emailValidatiorSpy = EmailValidatorSpy()
        let sut = makeSut(
            fieldName: "email",
            fieldLabel: "Email2",
            emailValidator: emailValidatiorSpy
        )
        emailValidatiorSpy.simulateInvalidEmail()
        let errorMessage = sut.validate(data: ["email": "invalid_email@mail.com"])
        XCTAssertEqual(errorMessage, "O campo Email2 é inválido")
    }
    
    func test_validate_should_return_nil_if_valid_email_is_provided() {
        let sut = makeSut(
            fieldName: "email",
            fieldLabel: "Email2",
            emailValidator: EmailValidatorSpy()
        )
        let errorMessage = sut.validate(data: ["email": "invalid_email@mail.com"])
        XCTAssertNil(errorMessage)
    }
    
    func test_validate_should_return_nil_if_no_data_is_provided() {
        let sut = EmailValidation(
            fieldName: "email",
            fieldLabel: "Email",
            emailValidator: EmailValidatorSpy()
        )
        let errorMessage = sut.validate(data: nil)
        XCTAssertEqual(errorMessage, "O campo Email é inválido")
    }
}

extension EmailValidationTests {
    func makeSut(
        fieldName: String,
        fieldLabel: String,
        emailValidator: EmailValidatorSpy,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Validation {
        let sut = EmailValidation(fieldName: fieldName, fieldLabel: fieldLabel, emailValidator: emailValidator)
        checkMemoryLeak(for: sut)
        return sut
    }
}
