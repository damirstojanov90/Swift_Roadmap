//
//  ListWelcomeView.swift
//  SwiftUI Deliverables
//
//  Created by Damir Stojanov on 28.09.2026..
//

import SwiftUI

struct ListWelcomeView: View {
    var body: some View {
        VStack(spacing: 15) {
            Text("Welcome to List.")
                .font(.headline)
            Text("Tap the button to continue...")
                .font(.subheadline)

            NavigationLink {
                ListView(symbolLibrary: SymbolItem.library)
            } label: {
                DeliverableSelector(
                    sfSymbol: "list.triangle",
                    title: "List"
                )
                .foregroundStyle(.black)
            }
        }
        .navigationTitle("List - Welcome")
    }
}

#Preview {
    ListWelcomeView()
}
