//
//  Theme.swift
//  mynotes
//
//  Created by shalinth adithyan on 01/11/25.
//

import SwiftUI
import UIKit
import Combine

struct Theme {
    // Background colors
    static let background = Color(UIColor.systemBackground)
    static let secondaryBackground = Color(UIColor.secondarySystemBackground)
    static let tertiaryBackground = Color(UIColor.tertiarySystemBackground)

    // Text colors
    static let primaryText = Color(UIColor.label)
    static let secondaryText = Color(UIColor.secondaryLabel)
    static let tertiaryText = Color(UIColor.tertiaryLabel)

    // Grouped background colors (for list backgrounds)
    static let groupedBackground = Color(UIColor.systemGroupedBackground)
    static let secondaryGroupedBackground = Color(UIColor.secondarySystemGroupedBackground)

    // Separator
    static let separator = Color(UIColor.separator)

    // Accent color for highlights
    static let accent = Color.accentColor
}

// User preference for color scheme
class ThemeManager: ObservableObject {
    @Published var colorScheme: ColorScheme?

    static let shared = ThemeManager()

    private init() {
        // Load saved preference
        if let savedScheme = UserDefaults.standard.string(forKey: "colorScheme") {
            switch savedScheme {
            case "light":
                colorScheme = .light
            case "dark":
                colorScheme = .dark
            default:
                colorScheme = nil
            }
        }
    }

    func setColorScheme(_ scheme: ColorScheme?) {
        colorScheme = scheme

        // Save preference
        if let scheme = scheme {
            UserDefaults.standard.set(scheme == .light ? "light" : "dark", forKey: "colorScheme")
        } else {
            UserDefaults.standard.removeObject(forKey: "colorScheme")
        }
    }
}
