//
//  ListItem.swift
//  SwiftUI Deliverables
//
//  Created by Damir Stojanov on 05.10.2026..
//

import SwiftUI

struct ListItem: View {
    var symbolLibraryItem: SymbolItem

    var body: some View {
        HStack {
            Image(systemName: symbolLibraryItem.symbolName)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)

            VStack(alignment: .leading, spacing: 5) {
                Text(symbolLibraryItem.label)
                    .font(.title)
                    .fontWeight(.bold)

                Text(symbolLibraryItem.description)
                    .font(.footnote)
            }
        }
        .padding()
    }
}

#Preview {
    ListItem(
        symbolLibraryItem: SymbolItem.library[2]
    )
}
