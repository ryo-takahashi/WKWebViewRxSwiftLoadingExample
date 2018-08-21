import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var presentObserverLoadingWebViewControllerButton: UIButton!
    @IBOutlet weak var presentRxLoadingWebViewControllerButton: UIButton!
    @IBOutlet weak var presentRxWebkitControllerButton: UIButton!
    
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
        
        presentRxWebkitControllerButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.pushRxWebkitViewController()
            })
            .disposed(by: disposeBag)
        
    }
    
    private func presentWebViewController() {
        navigationController?.pushViewController(WKWebViewController(), animated: true)
    }
    
    private func presentRxWebViewController() {
        navigationController?.pushViewController(RxWKWebViewController(), animated: true)
    }
    
    private func pushRxWebkitViewController() {
        navigationController?.pushViewController(RxWebkitViewController(), animated: true)
    }
    
}
