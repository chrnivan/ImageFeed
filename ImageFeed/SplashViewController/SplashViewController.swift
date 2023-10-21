
import UIKit
import ProgressHUD

final class SplashViewController: UIViewController {
    
    //MARK: - Private Properties
    private let oauth2Service = OAuth2Service.shared
    private let oauth2TokenStorage = OAuth2TokenStorage.shared
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    private var alertPresenter: AlertPresenterProtocol?
    private let authViewControllerID = "AuthViewController"
    private let tabBarViewControllerID = "TabBarViewController"
    private let mainID = "Main"
    private let spleshScreenLogoImageView: UIImageView = {
        let viewImageLogoScreenSplesh = UIImageView()
        viewImageLogoScreenSplesh.image = UIImage(named: "SplashScreenLogo")
        viewImageLogoScreenSplesh.translatesAutoresizingMaskIntoConstraints = false
        
        return viewImageLogoScreenSplesh
    }()
    
    // MARK: - View Life Cycles
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let token = oauth2TokenStorage.token {
            self.fetchProfile(token: token)
        } else {
            switchToAuthViewController()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertPresenter = AlertPresenter(delegate: self)
        view.addSubview(spleshScreenLogoImageView)
        spleshScreenLogoImageViewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}
//MARK: - AuthViewControllerDelegate

extension SplashViewController: AuthViewControllerDelegate {
    private func switchToAuthViewController() {
        let storyboard = UIStoryboard(name: mainID, bundle: .main).instantiateViewController(identifier: authViewControllerID)
        guard let authViewController = storyboard as? AuthViewController else { return }
        authViewController.delegate = self
        authViewController.modalPresentationStyle = .fullScreen
        present(authViewController, animated: true)
    }
}

//MARK: - Private Functions

extension SplashViewController {
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String) {
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            UIBlockingProgressHUD.show()
            self.fetchOAuthToken(code)
        }
    }
    
    private func showToTabBarController() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        let tabBarController = UIStoryboard(name: mainID, bundle: .main)
            .instantiateViewController(withIdentifier: tabBarViewControllerID)
        window.rootViewController = tabBarController
    }
    
    private func fetchProfile(token: String) {
        profileService.fetchProfile(token) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                profileImageService.fetchProfileImageURL(
                    token: token,
                    username: data.userName
                ){ [ weak self ]_ in
                    self?.showToTabBarController()
                }
            case .failure:
                self.showNetworkError()
            }
            UIBlockingProgressHUD.dismiss()
        }
    }
    
    func spleshScreenLogoImageViewSetup() {
        NSLayoutConstraint.activate([
            spleshScreenLogoImageView.heightAnchor.constraint(equalToConstant: 77),
            spleshScreenLogoImageView.widthAnchor.constraint(equalToConstant: 74),
            spleshScreenLogoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spleshScreenLogoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func fetchOAuthToken(_ code: String) {
        oauth2Service.fetchOAuthToken(code) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let token):
                self.fetchProfile(token: token)
            case .failure:
                self.showNetworkError()
            }
            UIBlockingProgressHUD.dismiss()
        }
    }
}

//MARK: - AlertPresenter
extension SplashViewController {
    private func showNetworkError() {
            let alert = AlertModel(
                title: "Что-то пошло не так(",
                message: "Не удалось войти в систему",
                buttonText: "ОК",
                completion: { [weak self] in
                    guard let self = self else {
                        return
                    }
                })
        
        alertPresenter?.showError(for: alert)
    }
}
