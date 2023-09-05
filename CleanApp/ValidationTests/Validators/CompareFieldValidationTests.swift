import XCTest
@testable import Presentation
@testable import Validation

final class CompareFieldValidationTests: XCTestCase {
    func test_validate_should_return_error_if_comparation_fails() {
        let sut = makeSut(
            fieldName: "password",
            fieldNameToCompare: "passwordConfirmation",
            fiedlLabel: "Senha"
        )
        let errorMessage = sut.validate(
            data: [
                "password": "123",
                "passwordConfirmation": "1234"
            ]
        )
        XCTAssertEqual(errorMessage, "O campo Senha é inválido")
    }
    
    func test_validate_should_return_error_if_with_correct_fieldLabel() {
        let sut = makeSut(
            fieldName: "password",
            fieldNameToCompare: "passwordConfirmation",
            fiedlLabel: "Confirmar Senha"
        )
        let errorMessage = sut.validate(
            data: [
                "password": "123",
                "passwordConfirmation": "1234"
            ]
        )
        XCTAssertEqual(errorMessage, "O campo Confirmar Senha é inválido")
    }
    
    func test_validate_should_return_nil_if_comparation_succedes() {
        let sut = makeSut(
            fieldName: "password",
            fieldNameToCompare: "passwordConfirmation",
            fiedlLabel: "Senha"
        )
        let errorMessage = sut.validate(
            data: [
                "password": "123",
                "passwordConfirmation": "123"
            ]
        )
        XCTAssertNil(errorMessage)
    }
    
    func test_validate_should_return_nil_if_no_data_is_provided() {
        let sut = makeSut(
            fieldName: "password",
            fieldNameToCompare: "passwordConfirmation",
            fiedlLabel: "Senha"
        )
        let errorMessage = sut.validate(data: nil)
        XCTAssertEqual(errorMessage, "O campo Senha é inválido")
    }
}


extension CompareFieldValidationTests {
    func makeSut(
        fieldName: String,
        fieldNameToCompare: String,
        fiedlLabel: String,
        file: StaticString = #file,
        line: UInt = #line
    ) -> CompareFieldsValidation {
        let sut = CompareFieldsValidation(
            fieldName: fieldName,
            fieldNameToCompare: fieldNameToCompare,
            fiedlLabel: fiedlLabel
        )
        checkMemoryLeak(for: sut)
        return sut
    }
}

