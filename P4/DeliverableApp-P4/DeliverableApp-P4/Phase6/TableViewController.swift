//
//  TableViewController.swift
//  DeliverableApp-P4
//
//  Created by Damir Stojanov on 14.09.2026..
//

import UIKit

/** Phase 6 - Deliverable 1

 Create a small application with UIKit view which will contain a welcome screen and
 a button “Proceed”. On tap on the button show next view which will contain a table
 view with cca 100 items (to make it scrollable)
 Create a small application with UIKit, with a welcom
*/

class TableViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("📣 Running:      TableViewController.viewDidLoad()")
        view.backgroundColor = .systemBackground
        title = "P6 - D1 - Table - Welcome screen"
        setupUI()
    }

    lazy var proceedButton: UIButton = {
        let button = UIButton()

        var config = UIButton.Configuration.prominentClearGlass()
        config.title = "Proceed"
        config.buttonSize = .large
        config.contentInsets = NSDirectionalEdgeInsets(top: 25, leading: 100, bottom: 25, trailing: 100)

        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showTable), for: .touchUpInside)
        return button
    }()

    func setupUI() {
        view.addSubview(proceedButton)
        NSLayoutConstraint.activate([
            proceedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            proceedButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func showTable() {
        print("🔧 TableViewController showTable()")
        let itemsTableVC = ItemsTableViewController()
        /// You don't need to define a navigationController property, if you type navigationController?,
        /// the current VC will look for the first ancestor in it's hierarchy which is a navigationController and use it
        navigationController?.pushViewController(itemsTableVC, animated: true)
    }
}
