//
//  SceneDelegate.swift
//  LGHTSG
//
//  Created by HA on 2023/01/09.
//

import UIKit
import Alamofire

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowscene = (scene as? UIWindowScene) else { return }
                window = UIWindow(windowScene: windowscene)
                window?.backgroundColor = .systemBackground
        //window?.rootViewController = ViewController()
          
        // MARK: 회원가입 체크 초기화
        UserDefaults.standard.set(false, forKey: "allcheck")
        UserDefaults.standard.set(false, forKey: "check1")
        UserDefaults.standard.set(false, forKey: "check2")
        UserDefaults.standard.set(false, forKey: "check3")
        
        
        
        // MARK: 자동로그인을 위한 코드
        var loginSuccess : Bool = UserDefaults.standard.bool(forKey: "loginSuccess") ?? false
        
        print("자동로그인 \(loginSuccess)")
        
        if loginSuccess == true {
            // MARK: 마지막 로그인 기록
            let email = UserDefaults.standard.string(forKey: "email")
            let password = UserDefaults.standard.string(forKey: "password")
            
            let bodyData : Parameters = [
                "email" : email,
                "password" : password
            ]
            
            LoginApiModel().requestLoginDataModel(bodyData: bodyData){
                data in
                print(data.accessToken)
                print("자동로그인 성공")
                UserDefaults.standard.set(data.accessToken, forKey: "savedToken")
                self.window?.rootViewController = MainTabController()
            }
        }
        else if loginSuccess == false {
            window?.rootViewController = ViewController()
        }
           
                window?.tintColor = .label
                window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

