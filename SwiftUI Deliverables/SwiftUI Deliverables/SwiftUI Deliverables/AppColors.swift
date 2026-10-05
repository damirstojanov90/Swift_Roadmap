//
//  AppColors.swift
//  SwiftUI Deliverables
//
//  Created by Damir Stojanov on 28.09.2026..
//

import SwiftUI

enum AppColors: String, CaseIterable {
    case acidYellow = "AcidYellow"
    case champagneGold = "ChampagneGold"
    case electricBlue = "ElectricBlue"
    case hyperTurquoise = "HyperTurquoise"
    case laserPurple = "LaserPurple"
    case lavenderBliss = "LavenderBliss"
    case midnightGreen = "MidnightGreen"
    case mistyMorning = "MistyMorning"
    case peachParfait = "PeachParfait"
    case radicalRed = "RadicalRed"
    case smokeGrey = "SmokeGrey"
    case steelBlue = "SteelBlue"

    var color: Color { Color(rawValue) }
}
