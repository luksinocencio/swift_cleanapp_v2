import Foundation

@testable import Presentation

public class LoadingViewSpy: LoadingView {
    var emit: ((LoadingViewModel) -> Void)?

    func observe(completion: @escaping (LoadingViewModel) -> Void) {
        self.emit = completion
    }

    public func display(viewModel: LoadingViewModel) {
        self.emit?(viewModel)
    }
}
