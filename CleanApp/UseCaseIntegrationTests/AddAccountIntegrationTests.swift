import XCTest

@testable import Data
@testable import Domain
@testable import Infra

class AddAccountIntegrationTests: XCTestCase {
    // TODO: - Usar Api local
    func test_add_account() {
        let alamofireAdapter = AlamofireAdapter()
        // URL fora do ar
        let url = URL(string: "https://fordevs.herokuapp.com/api/signup")!
        let sut = RemoteAddAccount(url: url, httpClient: alamofireAdapter)
        let addAccountModel = AddAccountModel(name: "Lucas Inocencio", email: "luksinocencio@outlook.com", password: "secret", passwordConfirmation: "secret")
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel: addAccountModel) { result in
            switch result {
            case .failure: XCTFail("Expect success got \(result) instead")
            case .success(let account):
                XCTAssertNil(account.accessToken)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 10)
    }
}
