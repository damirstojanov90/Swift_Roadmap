//
//  AppCoordinator.swift
//  DeliverableApp-P4
//
//  Created by Damir Stojanov on 14.09.2026..
//

import UIKit
/** USING THE COORDINATOR PATTERN:
 - used to manage navigation flow - instead of VCs handling navigation (push/pop), this is delegated to the coordinators
 - coordinators control the flow, view controller handle the view
 - PROS:
    - keeps VCs focused on UI logic
    - makes navigation easier to test and reuse and avoids duplication of navigation logic
    - improves app structure and scalability

 - STEP 1
    - define Coordinator protocol
    - defines a base for all coordinators, with each coordinator managing a flow of screens
 - STEP 2
    - create the AppCoordinator: Coordinator class managing the flow of the entire app
 - STEP 3
    - create HomeViewController - or whatever we want to call the root VC
    - add a HomeViewControllerDelegate protocol
 - STEP 4
    - conform AppCoordinator to HomeViewControllerDelegate (see func `didTapShowTable()`)
 - STEP 5
    - create other VCs (`TableViewController`) and configure them
 - STEP 6
    - launch the AppCoordinator from `SceneDelegate.swift` (or AppDelegate.swift)

 - as the app grows, you can split the flow into smaller coordinators like dedicated AuthCoordinator: Coordinator
 or ProfileCoordinator: Coordinator classes that handle login/signup, profile-related screens, etc.
 - if adding multiple coordinators, it is useful to track them in the "main" coordinator using an array
 `var childCoordinators: [Coordinator] = []`
 once a coordinator is created, it is appended, and once it is finished, it is removed from the array to prevent leaks.

 IMPORTANT:
 If using an AppCoordinator, you can remove Main.storyboard, just keep in mind you need to modify your `app.xcodeproj`'s
 Info.plist Values and remove Main from `UIKit Main Storyboard File Base Name`, otherwise you'll get errors!
 */
protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

class AppCoordinator: Coordinator {
    /**
     UINavigationControllers manage one or more contained VCs in a navigation interface where only
     one VC is visible at a time.
     Selecting an item pushes a new VC on screen, hiding the previous VC. Tapping the provided
     back button at the top of the interface pops the top VC, showing the previous one.

     A NavigationController object manages it's VCs using an ordered array - a NAVIGATION STACK.
     The first VC in the stack is the ROOT VC and represents the BOTTOM of the stack.
     The last VC is the TOPMOST item on the stack and is being currently displayed.
     */
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        /**
         func start() of the AppCoordinator class is used to set the root view controller,
         and asign AppCoordinator as it's delegate.
         The AppCoordinator gets notified about navigation events and then responds to them.
         */
        let homeViewController = HomeViewController()
        homeViewController.delegate = self
        navigationController.pushViewController(homeViewController, animated: false)
    }
}

extension AppCoordinator: HomeViewControllerDelegate {
    func didTapShowTable() {
        print("📲 AppCoordinator: HomeViewControllerDelegate - func didTapShowTable() - creating TableViewController()")
        let tableVC = TableViewController()
        navigationController.pushViewController(tableVC, animated: true)
    }
}
