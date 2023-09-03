import Foundation

@testable import Presentation

public class AlertViewSpy: AlertView {
    var emit: ((AlertViewModel) -> Void)?

    func observe(completion: @escaping (AlertViewModel) -> Void) {
        self.emit = completion
    }

    public func showMessage(viewModel: AlertViewModel) {
        self.emit?(viewModel)
    }
}
