//
//  ViewController.swift
//  DeliverableApp-P4
//
//  Created by Damir Stojanov on 27.05.2026..
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func didTapDeliverable1()
    func didTapDeliverable2()
}

/// HomeViewController
///
/// "Main" ViewController in the app.
/// Buttons used to instantiate different VC's and push them on the view stack using HomeViewControllerDelegate.
class HomeViewController: UIViewController {
    weak var delegate: HomeViewControllerDelegate?

    private lazy var allButtons: [UIButton] = [
        disableAllButton, enableAllButton,
        p6d1Button, p6d2Button
    ]

    override func viewDidLoad() {
        print("📣 Running:      HomeViewController.viewDidLoad()")
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "HOME VIEW CONTROLLER"
        addButtons()
    }

    // TODO: Try to reduce button creation and configuration?

    /**
     ACCESIBILITY:

     UIButton.Configuration automatically uses Dynamic Types so
     any titles, or SF icons set via Configuration should automatically
     respond to adjusting Display & Text Large Text size.

     Using Smart Invert will always work since it inverts colors for any view and doesn't
     care if colors were set using configuration or using setTitle / setTintColor,

     However, not using Configurations and setting button titles, images,
     etc. using UIButton methods will not automatically respond to those changes.

     NOTE: Curiously enough, UIImages will respond, so the "hand.tap" icon in firstButton will
     increase in size as Larger Text size is adjusted, but the text will stay the same size.
     */
    lazy var disableAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("Tap me!", for: .normal)
        button.setImage(UIImage(systemName: "hand.tap"), for: .normal)
/// HIG - COLOR - Make sure all your app's colors work well in light, dark, and increased contrast contexts.
/// - hardocded .black and .orange are not semantic/system or asset colors so they won't shift for
/// Dark Mode or increased contrast settings (even the descriptions say so)
/// - also, if not using Configurations, setTitleColor only works on text, and tintColor only on the image!
        button.setTitleColor(.label, for: .normal)
        button.tintColor = .label
        button.backgroundColor = .systemIndigo
        button.layer.cornerRadius = 10
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        /**
         Images/icons attached to buttons already track the dynamic type size changes.
         This property prevents scaling past the standard range
         (if "Larger Accessibility Sizes" is ON) and is false by default.
         */
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(disableAllButtons), for: .touchUpInside)
        // button.adjustsImageSizeForAccessibilityContentSizeCategory = true
        return button
    }()

    lazy var enableAllButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.borderedTinted()
        config.title = "Tap me!"
        config.subtitle = "I might enable all buttons..."
        config.image = UIImage(systemName: "hand.tap")
        config.imagePlacement = .trailing
        config.imagePadding = 30
        config.baseForegroundColor = .systemBlue

        button.configuration = config

        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(enableAllButtons), for: .touchUpInside)
        return button
    }()

    lazy var toggleButtonRow: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [disableAllButton, enableAllButton])
        stack.axis = .horizontal
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    // p6d1 -> short form for Phase 6 Deliverable 1
    lazy var p6d1Button: UIButton = {
        let button = UIButton(
            type: .system
        )
        var config = UIButton.Configuration.prominentGlass()
        config.title = "TABLE"
        config.subtitle = "Phase 6, Deliverable 1"
        config.image = UIImage(systemName: "tablecells.fill")
        config.imagePlacement = .leading
        config.imagePadding = 10

        button.configuration = config
        button.addTarget(self, action: #selector(goToP6D1), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var p6d2Button: UIButton = {
        let button = UIButton(type: .system)

        var config = UIButton.Configuration.borderedTinted()
        config.title = "COLORS"
        config.subtitle = "Phase 6, Deliverable 2"
        config.image = UIImage(systemName: "paintpalette")
        config.imagePlacement = .leading
        config.imagePadding = 10

        button.configuration = config
        button.addTarget(self, action: #selector(goToP6D2), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var deliverableButtonColumn: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [p6d1Button, p6d2Button])
        stack.axis = .vertical
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    @objc private func goToP6D1() {
        delegate?.didTapDeliverable1()
    }

    @objc private func goToP6D2() {
        delegate?.didTapDeliverable2()
    }

    @objc func disableAllButtons() {
        for button in allButtons {
            if button == enableAllButton {
                continue
            }
            button.isEnabled = false
        }
    }

    @objc func enableAllButtons() {
        for button in allButtons {
            button.isEnabled = true
        }
    }

    private func addButtons() {
        view.addSubview(toggleButtonRow)
        view.addSubview(deliverableButtonColumn)
        NSLayoutConstraint.activate([
            deliverableButtonColumn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deliverableButtonColumn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            toggleButtonRow.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toggleButtonRow.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
