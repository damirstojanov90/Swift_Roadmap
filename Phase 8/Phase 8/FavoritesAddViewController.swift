//
//  FavoritesAddViewController.swift
//  Phase 8
//
//  Created by Damir Stojanov on 12.10.2026..
//

import UIKit

class FavoritesAddViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set navigation title using navigationItem:
        navigationItem.title = "Add Favorite"

        /// Hide back button text:
        /// The chevron only icon is the default for navigation back buttons.
        /// To actually set the text, you need to set it in the pushing VC: `navigationItem.backButtonTitle = "Favorites"`!
        /// To hide the text, either:
        ///     1. Do not explicitly set `navigationItem.backButtonTitle`
        ///     2. Set the title, but then set `navigationItem.backButtonDisplayMode = .minimal` which shows the chevron only
        ///     - See `FavoritesViewController override viewDidLoad()`
        /// Bottom line: The back button basically belongs to the screen underneath, or the pushing VC, so that's where you need to set the text.
        /// Bonus: using `navigationItem.hidesBackButton = true` in the current VC will completely hide the back button,
        /// although it will make configuring the title and button in the previous VC redundant.
        navigationItem.hidesBackButton = true
//        navigationController?.setNavigationBarHidden(false, animated: true)
        addMenuToNavBar()
    }

    private func addMenuToNavBar() {
        // Add a right bar button with menu:
        let homeAction = UIAction(title: "Home", image: UIImage(systemName: "house")) { [weak self] _ in
            print("FavoritesAddViewController -> Home selected!")
            self?.goHome()
        }

        let favoritesAction = UIAction(title: "Favorites", image: UIImage(systemName: "star")) { [weak self] _ in
            print("FavoritesAddViewController -> Favorites selected!")
            self?.goFavorites()
        }

        let settingsAction = UIAction(title: "Settings", image: UIImage(systemName: "gear")) { [weak self] _ in
            print("FavoritesAddViewController -> Settings selected!")
            self?.goSettings()
        }

        let menu = UIMenu(title: "Menu", children: [homeAction, favoritesAction, settingsAction])
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), menu: menu)
        navigationItem.rightBarButtonItem = menuButton
    }

    /// PRO-TIP: Instead of using `tabBarController?.selectedIndex = 0`, create a enum Tab conforming to Int,
    /// define cases as tab names and use `Tab.home.rawValue`.
    private func goHome() {
        tabBarController?.selectedIndex = Tabs.home.rawValue
    }

    private func goFavorites() {
        /// Prevents FavoritesAddViewController from staying in the stack...
        navigationController?.popToRootViewController(animated: true)
        tabBarController?.selectedIndex = Tabs.favorites.rawValue
    }

    private func goSettings() {
        tabBarController?.selectedIndex = Tabs.settings.rawValue
    }
}
