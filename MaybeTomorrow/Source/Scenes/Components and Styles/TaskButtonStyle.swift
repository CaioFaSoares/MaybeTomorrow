//
//  TaskButtonStyle.swift
//  MaybeTomorrow
//
//  Created by Caio Soares on 27/05/23.
//

import Foundation
import SwiftUI

struct taskButtonStyle: ButtonStyle {
    var level: taskImportanceLevels
    var selectedLevel: taskImportanceLevels
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.all)
            .background(level.color == selectedLevel.color ? level.color : level.color.opacity(0.5))
            .scaleEffect(level.color == selectedLevel.color ? 1.33 : 1)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundColor(.white)
    }
}
