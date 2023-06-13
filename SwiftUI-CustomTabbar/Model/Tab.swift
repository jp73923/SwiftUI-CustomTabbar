//
//  Tab.swift
//  SwiftUI-CustomTabbar
//
//  Created by macOS on 13/06/23.
//

import SwiftUI

/// App Tab's
enum Tab: String, CaseIterable {
    case home = "Home"
    case collegues = "Collegues"
    case favourites = "Favourites"
    case notifications = "Notifications"
    
    var systemImage: String {
        switch self {
        case .home:
            return "house"
        case .collegues:
            return "person.and.person.fill"
        case .favourites:
            return "suit.heart.fill"
        case .notifications:
            return "bell"
        }
    }
    
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}
