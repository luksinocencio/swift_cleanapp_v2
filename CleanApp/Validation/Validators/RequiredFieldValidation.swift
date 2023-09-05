import Foundation
import Presentation

public class RequiredFieldValidation: Validation {
    private let fieldName: String
    private let fiedlLabel: String
    
    init(fieldName: String, fiedlLabel: String) {
        self.fieldName = fieldName
        self.fiedlLabel = fiedlLabel
    }
    
    public func validate(data: [String: Any]?) -> String? {
        guard let fieldName = data?[fieldName] as? String, !fieldName.isEmpty else {
            return  "O campo \(fiedlLabel) é obrigatório"
        }
        return nil
    }
}

