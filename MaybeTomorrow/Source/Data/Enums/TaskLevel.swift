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
        case .Unselected:   return Color.gray
        case .Simple:       return Color.green
        case .Medium:       return Color.yellow
        case .Hard:         return Color.orange
        case .Complex:      return Color.red
        }
    }
}

extension taskImportanceLevels: Identifiable {
    var id: Self { self }
}
