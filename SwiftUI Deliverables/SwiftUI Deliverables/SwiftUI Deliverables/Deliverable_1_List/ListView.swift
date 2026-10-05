//
//  ListView.swift
//  SwiftUI Deliverables
//
//  Created by Damir Stojanov on 05.10.2026..
//

import SwiftUI

struct ListView: View {
    var symbolLibrary: [SymbolItem]
    var body: some View {
        List {
            ForEach(symbolLibrary) { symbolItem in
                ListItem(symbolLibraryItem: symbolItem)
            }
        }
        .navigationTitle("List")
    }
}

#Preview {
    ListView(symbolLibrary: SymbolItem.library)
}
