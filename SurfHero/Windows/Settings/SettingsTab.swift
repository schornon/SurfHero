//
//  SettingsTab.swift
//  SurfHero
//
//  Created by Serhii Chornonoh on 05.06.2024.
//

import Foundation

enum SettingsTab: String, CaseIterable, Identifiable {
    case exceptions, statusBar
    
    var id: String {
        rawValue
    }
}
extension SettingsTab {
    var displayValue: String {
        return switch self {
        case .exceptions:
            "Exceptions"
        case .statusBar:
            "Status Bar"
        }
    }
}
