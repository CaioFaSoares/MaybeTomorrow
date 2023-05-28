//
//  TaskButtonStyle.swift
//  MaybeTomorrow
//
//  Created by Caio Soares on 27/05/23.
//

import Foundation
import SwiftUI

struct taskButtonStyle: ButtonStyle {
    var levelColor: Color
    var selectedLevel: taskImportanceLevels
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.all)
            .background(levelColor == selectedLevel.color ? levelColor : levelColor.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 10))
//            .scaledToFit()
//            .frame(maxWidth: UIScreen.main.bounds.width / 4)
            .foregroundColor(.white)
    }
}
