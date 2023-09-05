import Foundation
import Presentation

public class CompareFieldsValidation: Validation {
    private let fieldName: String
    private let fieldNameToCompare: String
    private let fiedlLabel: String
    
    init(fieldName: String, fieldNameToCompare: String, fiedlLabel: String) {
        self.fieldName = fieldName
        self.fieldNameToCompare = fieldNameToCompare
        self.fiedlLabel = fiedlLabel
    }
    
    public func validate(data: [String: Any]?) -> String? {
        guard let fieldName = data?[fieldName] as? String,
              let fieldNameToCompare = data?[fieldNameToCompare] as? String,
              fieldName == fieldNameToCompare
        else {
            return  "O campo \(fiedlLabel) é inválido"
        }
        return nil
    }
}
