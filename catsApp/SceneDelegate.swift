//
//  SceneDelegate.swift
//  catsApp
//
//  Created by santiago calvo on 27/05/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let CatsURL = URL(string: "https://api.thecatapi.com/v1/breeds")!
        
        let catsLoader = MainQueueDispatchDecorator(decoratee: RemoteCatsLoader(url: CatsURL, client: URLSessionHTTPClient(session: .shared)))
        
        let catsPresenter = CatsPresenter(catsLoader: catsLoader)
        let catsViewController = CatsViewController(catsPresenter: catsPresenter)
        catsPresenter.catsViewDelegate = catsViewController
        
        window.rootViewController = catsViewController
        window.makeKeyAndVisible()
        self.window = window
    }


}

