import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var presentObserverLoadingWebViewControllerButton: UIButton!
    @IBOutlet weak var presentRxLoadingWebViewControllerButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    private func setupViewController() {
        presentObserverLoadingWebViewControllerButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.presentWebViewController()
            })
            .disposed(by: disposeBag)
        
        presentRxLoadingWebViewControllerButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.presentRxWebViewController()
            })
            .disposed(by: disposeBag)
    }
    
    private func presentWebViewController() {
        navigationController?.pushViewController(WKWebViewController(), animated: true)
    }
    
    private func presentRxWebViewController() {
        navigationController?.pushViewController(RxWKWebViewController(), animated: true)
    }
}
