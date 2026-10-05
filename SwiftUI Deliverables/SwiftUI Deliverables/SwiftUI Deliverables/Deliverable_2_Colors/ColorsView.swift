//
//  ColorsView.swift
//  SwiftUI Deliverables
//
//  Created by Damir Stojanov on 28.09.2026..
//

import SwiftUI

struct ColorsView: View {
    @State var buttonColor: AppColors?
    @State var backgroundColor: AppColors?

    var body: some View {
        VStack(spacing: 15) {
            Text("Current background color: \(backgroundColor?.rawValue ?? "Clear")")
                .font(.title3)
            Text("Current button color: \(buttonColor?.rawValue ?? "Clear")")
                .font(.title3)
            Button(action: switchColors ) {
                Label("Switch colors!", systemImage: "paintpalette.fill")
                    .foregroundStyle(.black)
                    .font(.headline)
            }
            .buttonSizing(.flexible)
            .buttonStyle(.glassProminent)
            .tint(buttonColor?.color)
            .padding()
        }
        .navigationTitle("Colors")
        /// VStack modifiers:
        /// - the VStack sizes itself by it's contents, so .backrgound() would only paint behind it's actual frame
        /// - frame(maxWidth: .infinity, maxHeight: .infinity) forces the VStack to take up all available space BEFORE
        /// applying the background
        /// - .ignoresSafeArea() extends the color under the navigation button too
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor?.color)
        .ignoresSafeArea()
    }

    private func switchColors() {
        backgroundColor = buttonColor
        buttonColor = AppColors.allCases.randomElement()
    }
}

#Preview {
    ColorsView()
}
