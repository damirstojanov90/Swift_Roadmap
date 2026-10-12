//
//  HomeViewController.swift
//  Phase 8
//
//  Created by Damir Stojanov on 09.10.2026..
//

import UIKit

class HomeViewController: UIViewController {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "HomeViewController"
        label.font = .systemFont(ofSize: 30)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50)
        ])
    }
}

