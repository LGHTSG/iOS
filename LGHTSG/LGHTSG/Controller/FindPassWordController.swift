import UIKit

class FindPassWordController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let FindPwView = FindPwView()
        self.view.addSubview(FindPwView)
        view.backgroundColor = .black
        
        
        FindPwView.translatesAutoresizingMaskIntoConstraints = false
        FindPwView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        FindPwView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        FindPwView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        FindPwView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        
        // MARK: 네비게이션 컨트롤러
        self.view.addSubview(FindPwView.navigationBar)
        let safeArea = self.view.safeAreaLayoutGuide
        let navigationAppearance = UINavigationBarAppearance()
        
        navigationAppearance.backgroundColor = .black
        navigationAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        FindPwView.navigationBar.tintColor = UIColor.white
        FindPwView.navigationBar.standardAppearance = navigationAppearance
        FindPwView.navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        FindPwView.navigationBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        FindPwView.navigationBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        let navItem = UINavigationItem(title: "비밀번호 찾기")
        let leftButton = UIBarButtonItem(image: UIImage(named: "back-arrow"), style: .plain, target: self, action: #selector(tapDismissButton))
        
        navItem.leftBarButtonItem = leftButton
            
        FindPwView.navigationBar.setItems([navItem], animated: true)
        
        // MARK: 키보드 올라갔을 때 화면 터치해서 내려가게함
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapDismissButton(){
        var userId = UserDefaults.standard.string(forKey: "id")
        var pw = UserDefaults.standard.string(forKey: "pw")
        
        print("id : \(userId), pw : \(pw)")
        self.presentingViewController?.dismiss(animated: true)
    }

    

    
}
