//
//  D2ViewController.swift
//  DeliverableApp-P4
//
//  Created by Damir Stojanov on 17.09.2026..
//

import UIKit

/**
 Phase6 - Deliverable2

 Create a small application with UIKit, with a welcome screen and a button. On tap
 of button, itself should change color to a random color, background will get
 button’s previous color. Provide the colors within Assets, no hardcoding.
 */

class D2ViewController: UIViewController {
    // TODO: Figure out a way to avoid this:
    let deliverable2Colors = [
        "AcidYellow", "ChampagneGold", "ElectricBlue", "HyperTurquoise", "LaserPurple",
        "LavenderBliss", "MidnightGreen", "MistyMorning", "PeachParfait", "RadicalRed",
        "SmokeGrey", "SteelBlue"
    ]
    /**
     - string litterals in a list are prone to errors (a typo will cause a nil return in UIColor(named:)
     - putting the colors into an enum might be better
     - EXPLORE ways to get all the colors from Assets.xcassets maybe?
     */

    var currentButtonColor: UIColor?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("📣 Running:      D2ViewController.viewDidLoad()")
        view.backgroundColor = .systemBackground
        title = "P6 - D2 - Colors"
        setupUI()
    }

    lazy var colorSwitchButton: UIButton = {
        let button = UIButton()

        /// Can't use .borderedTinted() -> all Tinted styles show a translucent/pastel tint effect so the color
        /// is washed out and lightened.
        /// .prominentGlass() is also slightly washed out but better than .borderedTinted().
        /// .filled() creates a opaque, solid fill that matches baseBackgroundColor and auto-picks a
        /// contrasting foreground text color!
        var config = UIButton.Configuration.filled()
        config.title = "Switch Colors"
        config.buttonSize = .large
        config.contentInsets = NSDirectionalEdgeInsets(top: 25, leading: 25, bottom: 25, trailing: 25)

        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(switchColors), for: .touchUpInside)
        return button
    }()

    func setupUI() {
        view.addSubview(colorSwitchButton)
        NSLayoutConstraint.activate([
            colorSwitchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            colorSwitchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func switchColors() {
        if let currentButtonColor {
            view.backgroundColor = currentButtonColor
        }
        let randomColor = deliverable2Colors.randomElement().flatMap { UIColor(named: $0)}
        colorSwitchButton.configuration?.baseBackgroundColor = randomColor
    }

    // TODO: Explore Logging:
    /**
     if let currentButtonColor {
         view.backgroundColor = currentButtonColor
     } else {
         print("ℹ️ \(#fileID) \(#function): no previous button color yet (first tap) — background left untouched")
     }
     and for the real failure case in switchColors:
     print("💥 \(#fileID) \(#function): color asset lookup failed")
     ℹ️ = expected state, 💥 = actual bug — same glance-ability you already have, no new dependency.

     If you want real observability (filterable log levels, visible in Console.app, searchable by subsystem) rather than scrollback prints, the native tool is Logger from import os — no third-party dependency needed:
     import os
     private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "D2", category: "ColorSwitch")

     logger.info("No previous button color yet (first tap)")
     logger.error("Color asset lookup failed")
     That's the right call if this app grows past a couple of view controllers and you actually need to filter/search logs later — for a single-screen deliverable, plain print with your emoji convention is enough. Your call which one fits what you're going for.
     */
}
