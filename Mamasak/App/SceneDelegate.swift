//
//  SceneDelegate.swift
//  Mamasak
//
//  Created by yxgg on 12/05/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(windowScene: windowScene)
    let mainView = FtuxViewController()
    window.rootViewController = mainView
    window.makeKeyAndVisible()
    self.window = window
  }
}

