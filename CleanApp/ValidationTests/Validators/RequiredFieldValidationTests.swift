import XCTest
@testable import Presentation
@testable import Validation

final class RequiredFieldValidationTests: XCTestCase {
    func test_validate_should_return_error_if_field_is_not_provided() {
        let sut = makeSut(fieldName: "email", fiedlLabel: "Email")
        let errorMessage = sut.validate(data: ["name": "Lucas"])
        XCTAssertEqual(errorMessage, "O campo Email é obrigatório")
    }
    
    func test_validate_should_return_error_with_correct_fieldLabel() {
        let sut = makeSut(fieldName: "email", fiedlLabel: "Idade")
        let errorMessage = sut.validate(data: ["name": "Lucas"])
        XCTAssertEqual(errorMessage, "O campo Idade é obrigatório")
    }
    
    func test_validate_should_return_nil_if_field_is_provided() {
        let sut = makeSut(fieldName: "email", fiedlLabel: "Email")
        let errorMessage = sut.validate(data: ["email": "luksinocencio@mail.com"])
        XCTAssertNil(errorMessage)
    }
    
    func test_validate_should_return_nil_f_field_is_provided() {
        let sut = makeSut(fieldName: "email", fiedlLabel: "Email")
        let errorMessage = sut.validate(data: ["email": "luksinocencio@mail.com"])
        XCTAssertNil(errorMessage)
    }
}


extension RequiredFieldValidationTests {
    func makeSut(
        fieldName: String,
        fiedlLabel: String,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Validation {
        let sut = RequiredFieldValidation(fieldName: fieldName, fiedlLabel: fiedlLabel)
        checkMemoryLeak(for: sut)
        return sut
    }
}
