//
//  TaskLevel.swift
//  MaybeTomorrow
//
//  Created by Caio Soares on 27/05/23.
//

import Foundation
import SwiftUI

enum taskImportanceLevels: Int, CaseIterable {
    
    case Unselected = -1
    case Simple
    case Medium
    case Hard
    case Complex
    
    var color: Color {
        switch self {
        case .Unselected:   return Color.gray
        case .Simple:       return Color.green
        case .Medium:       return Color.yellow
        case .Hard:         return Color.orange
        case .Complex:      return Color.red
        }
    }
    
    var emoji: String {
        switch self {
        case .Unselected:   return "🧐"
        case .Simple:       return "🥳"
        case .Medium:       return "😤"
        case .Hard:         return "😡"
        case .Complex:      return "🤬"
        }
    }
    
    var days: String {
        switch self {
        case .Unselected:   return "0"
        case .Simple:       return "2"
        case .Medium:       return "5"
        case .Hard:         return "7"
        case .Complex:      return "10"
        }
    }
}

extension taskImportanceLevels: Identifiable {
    var id: Self { self }
}
