//
//  HomeView.swift
//  MaybeTomorrow
//
//  Created by Caio Soares on 27/05/23.
//

import SwiftUI

struct HomeView: View {
    
    init(_ root: rootModel) {
        self.viewModel = HomeViewModel(root)
    }
    
    @ObservedObject private var viewModel: HomeViewModel
    
    @State var username = "functionality underway"
    
    var body: some View {
        Section {   /// Profile for customization
            ZStack {
                Circle()
                    .foregroundColor(Color(uiColor: .tertiarySystemBackground))
                Image(systemName: "person")
                    .foregroundColor(Color(uiColor: .secondaryLabel))
                    
            }
            .scaledToFit()
            .frame(width: UIScreen.main.bounds.width / 3)
            VStack(alignment: .trailing) {
                HStack() {
                    TextField("functionality underway!", text: $username)
                        .padding(.all)
                        .disabled(true)
//                    Text("#\("0451")")
//                        .font(.footnote)
//                        .padding(.all)
//                        .foregroundColor(Color(uiColor: .secondaryLabel))
                }
                .background(Color(uiColor: .tertiarySystemBackground))
                .cornerRadius(10)
            }
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.large)
        .listSectionSeparator(.visible)
        Section {   /// stat section!
            Text("Oi")
        }
        .listSectionSeparator(.visible)
        Spacer()
            .frame(idealHeight: 0)
        Section {   /// Giant button for the player to click on and add a task.
            Group {
                Color.accentColor
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.all)
        }
        .listSectionSeparator(.visible)
    }
}
