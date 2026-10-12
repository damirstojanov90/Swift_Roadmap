//
//  FavoritesViewController.swift
//  Phase 8
//
//  Created by Damir Stojanov on 09.10.2026..
//

import UIKit

class FavoritesViewController: UIViewController {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "FavoritesViewController"
        label.font = .systemFont(ofSize: 30)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var addButton: UIButton = {
        var configuration = UIButton.Configuration.prominentGlass()
        configuration.title = "Add"
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 25, leading: 50, bottom: 25, trailing: 50)

        let button = UIButton(configuration: configuration)
        button.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    @objc func addButtonAction() {
        print("Add button tapped, pushing new VC in nav stack.")
        let favoritesAddVC = FavoritesAddViewController()
        navigationController?.pushViewController(favoritesAddVC, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

//        navigationItem.backButtonTitle = "Favorites"
//        navigationItem.backButtonDisplayMode = .minimal

        /// Since FavoritesViewController lives inside a UINavigationController, the navigation bar takes up
        /// space at the top, so safeAreaLayoutGuide.topAnchor is lower than in the other views!
        /// You can use `setNavigationBarHidden()` or `isNavigationBarHidden = true` to hide it,
        /// but that hides ot from the pushed screen too, so you have to enable it in that VC.
//        navigationController?.setNavigationBarHidden(true, animated: true)

        view.addSubview(titleLabel)
        view.addSubview(addButton)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            addButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            addButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
}

