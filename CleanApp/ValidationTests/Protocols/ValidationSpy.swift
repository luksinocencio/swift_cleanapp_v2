import Foundation
@testable import Presentation

public class ValidationSpy: Validation {
    var errorMessage: String?
    var data: [String: Any]?
    
    public func validate(data: [String : Any]?) -> String? {
        self.data = data
        return errorMessage
    }
    
    func simulateError(_ errorMessage: String) {
        self.errorMessage = errorMessage
    }
}
