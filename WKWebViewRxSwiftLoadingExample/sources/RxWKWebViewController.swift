import UIKit
import WebKit
import RxSwift
import RxCocoa
import RxOptional

class RxWKWebViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var progressView: UIProgressView!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }
    
    private func setupWebView() {

        // プログレスバーの表示制御、ゲージ制御、アクティビティインジケータ表示制御で使うため、一旦オブザーバを定義
        let loadingObservable = webView.rx.observe(Bool.self, "loading")
            .filterNil()
            .share()
        
        // プログレスバーの表示・非表示
        loadingObservable
            .map { return !$0 }
            .observeOn(MainScheduler.instance)
            .bind(to: progressView.rx.isHidden)
            .disposed(by: disposeBag)
        
        // iPhoneの上部の時計のところのバーの（名称不明）アクティビティインジケータ表示制御
        loadingObservable
            .bind(to: UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
        
        // NavigationControllerのタイトル表示
        loadingObservable
            .map { [weak self] _ in return self?.webView.title }
            .observeOn(MainScheduler.instance)
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        // プログレスバーのゲージ制御
        webView.rx.observe(Double.self, "estimatedProgress")
            .filterNil()
            .map { return Float($0) }
            .observeOn(MainScheduler.instance)
            .bind(to: progressView.rx.progress)
            .disposed(by: disposeBag)
        

        let url = URL(string: "https://www.google.com/")
        let urlRequest = URLRequest(url: url!)
        webView.load(urlRequest)
    }
}
