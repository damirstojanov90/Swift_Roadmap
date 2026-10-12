//
//  SceneDelegate.swift
//  Phase 8
//
//  Created by Damir Stojanov on 09.10.2026..
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        /// Programatically setting app UI:
        /// 1. Remove Main.storyboard
        /// 2. Update Info.plist
        ///     - remove key UISceneStoryboardFile
        ///     - ensure UIApplicationSceneManifest is present for scene support (always in iOS 13+)
        ///     - verify "Main Interface" is blank in Project Settings > General > Deployment Info
        /// 3. initialize window with windowScene
        /// 4. set window?.rootViewController
        /// 5. call window?.makeKeyAndVisible()
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        // Create tabBarController:
        let tabBarController = UITabBarController()

        // Create VCs to be added to tabBarController:
        let homeVC = HomeViewController()
        let favoritesVC = FavoritesViewController()
        let settingsVC = SettingsViewController()

        // Wrap favoritesVC in UINavigationController to allow hierarchical navigation within the tab:
        let favoritesNav = UINavigationController(rootViewController: favoritesVC)

        // Add VCs to tabBarController using setViewControllers:
        tabBarController.setViewControllers([homeVC, favoritesNav, settingsVC], animated: false)

        // Customizing Tab Bar Items:
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.circle.fill"), tag: 1)
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star.circle.fill"), tag: 2)
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear.circle.fill"), tag: 3)

        /// You can set initial open tab by using `tabBarController.selectedIndex = Int`to
        /// set the initial tab, otherwise it's always going to be the first on that was added.

        tabBarController.tabBar.tintColor = .systemBlue
        window?.rootViewController = tabBarController
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

