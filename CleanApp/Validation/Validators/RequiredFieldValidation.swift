import Foundation
import Presentation

public class RequiredFieldValidation: Validation, Equatable {
    
    
    private let fieldName: String
    private let fiedlLabel: String
    
    public init(fieldName: String, fiedlLabel: String) {
        self.fieldName = fieldName
        self.fiedlLabel = fiedlLabel
    }
    
    public func validate(data: [String: Any]?) -> String? {
        guard let fieldName = data?[fieldName] as? String, !fieldName.isEmpty else {
            return  "O campo \(fiedlLabel) é obrigatório"
        }
        return nil
    }
    
    public static func == (lhs: RequiredFieldValidation, rhs: RequiredFieldValidation) -> Bool {
        return lhs.fiedlLabel == rhs.fiedlLabel && lhs.fieldName == rhs.fieldName
    }
}

