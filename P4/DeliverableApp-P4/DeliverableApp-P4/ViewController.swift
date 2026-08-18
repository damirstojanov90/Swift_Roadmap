//
//  ViewController.swift
//  DeliverableApp-P4
//
//  Created by Damir Stojanov on 27.05.2026..
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        print("📣 Running:      ViewController.viewDidLoad()")
        super.viewDidLoad()
        addButtons()
    }

    /* ACCESIBILITY:

     UIButton.Configuration automatically uses Dynamic Types so
     any titles, or SF icons set via Configuration will
     respond to adjusting Display & Text Large Text size.

     Using Smart Invert will always work since it inverts colors for any view and doesn't
     care if colors were set using configuration or using setTitle / setTintColor,

     However, not using Configurations and setting button titles, images,
     etc. using UIButton methods will not automatically respond to those changes.

     NOTE: Curiously enough, UIImages will respond, so the "hand.tap" icon in firstButton will
     increase in size as Larger Text size is adjusted, but the text will stay the same size.
     */

    lazy var firstButton: UIButton = {
        let button = UIButton(
            type: .custom
        )
        button.setTitle("Tap me!", for: .normal)
        button.setImage(UIImage(systemName: "hand.tap"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .black
        button.backgroundColor = .orange
        button.layer.cornerRadius = 15
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)

        /// Images/icons attached to buttons already track the dynamic type size changes.
        /// This property prevents scaling past the standard range (if "Larger Accessibility Sizes" is ON) and is false by default.
        // button.adjustsImageSizeForAccessibilityContentSizeCategory = true

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var secondButton: UIButton = {
        let button = UIButton(
            type: .custom
        )
        var config = UIButton.Configuration.borderedTinted()
        config.title = "Tap me!"
        config.image = UIImage(systemName: "hand.tap")
        config.imagePlacement = .trailing
        config.imagePadding = 15
        config.baseForegroundColor = .systemBlue

        button.configuration = config

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private func addButtons() {
        view.addSubview(firstButton)
        view.addSubview(secondButton)
        NSLayoutConstraint.activate([
            firstButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            firstButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            secondButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 15),
            secondButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        ])
    }
}
