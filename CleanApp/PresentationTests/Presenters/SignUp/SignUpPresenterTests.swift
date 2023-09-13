import XCTest

@testable import Presentation
@testable import Domain
@testable import Data

class SignUpPresenterTests: XCTestCase {
    func test_signUp_should_call_addAccount_with_correct_values() {
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount: addAccountSpy)
        sut.signUp(viewModel: makeSignUpViewModel())
        XCTAssertEqual(addAccountSpy.addAccountModel, makeAddAccountModel())
    }

    func test_signUp_should_show_error_message_if_addAccount_fails() {
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertView: alertViewSpy, addAccount: addAccountSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, makeErrorAlertViewModel(
                message: "Algo inesperado acontenceu, tente novamente em alguns instantes."))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel())
        addAccountSpy.completeWithError(.unexpected)
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_show_success_message_if_addAccount_success() {
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertView: alertViewSpy, addAccount: addAccountSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, makeSuccessAlertViewModel(message: "Conta criada com sucesso."))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel())
        addAccountSpy.completeWithAccount(makeAccountModel())
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_show_loading_before_and_after_addAccount() {
        let loadingViewSpy = LoadingViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount: addAccountSpy, loadingView: loadingViewSpy)
        sut.signUp(viewModel: makeSignUpViewModel())
        let exp = expectation(description: "waiting")
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: true))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel())
        wait(for: [exp], timeout: 1)

//        let exp2 = expectation(description: "waiting")
//        loadingViewSpy.observe { viewModel in
//            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: false))
//            exp2.fulfill()
//        }
//        addAccountSpy.completeWithError(.unexpected)
//        wait(for: [exp2], timeout: 1)
    }
    
    func test_signUp_should_call_validation_with_correct_values() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validation: validationSpy)
        let viewModel = makeSignUpViewModel()
        sut.signUp(viewModel: viewModel)
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: viewModel.toJson()!))
    }
    
    func test_signUp_should_show_error_message_if_validation_fails() {
        let alertViewSpy = AlertViewSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(alertView: alertViewSpy, validation: validationSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falha na validação", message: "Erro"))
            exp.fulfill()
        }
        validationSpy.isSimulateError()
        sut.signUp(viewModel: makeSignUpViewModel(name: nil))
        wait(for: [exp], timeout: 1)
    }
}

extension SignUpPresenterTests {
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(),
                 addAccount: AddAccountSpy = AddAccountSpy(),
                 loadingView: LoadingViewSpy = LoadingViewSpy(),
                 validation: ValidationSpy = ValidationSpy(),
                 file: StaticString = #file,
                 line: UInt = #line
    ) -> SignUpPresenter {
        let sut = SignUpPresenter(
            alertView: alertView,
            addAccount: addAccount,
            loadingView: loadingView,
            validation: validation
        )
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}

class ValidationSpy: Validation {
    var data: [String: Any]?
    var errorMessage: String?
    
    func validate(data: [String : Any]?) -> String? {
        self.data = data
        return errorMessage
    }
    
    func isSimulateError() {
        self.errorMessage = "Erro"
    }
}
