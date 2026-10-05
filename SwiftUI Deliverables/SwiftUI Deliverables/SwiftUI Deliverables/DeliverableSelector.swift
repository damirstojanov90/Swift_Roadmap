//
//  DeliverableSelector.swift
//  SwiftUI Deliverables
//
//  Created by Damir Stojanov on 05.10.2026..
//

import SwiftUI

struct DeliverableSelector: View {
    var sfSymbol: String
    var title: String?
    var subtitle: String?
    var body: some View {
        HStack {
            Image(systemName: sfSymbol)
            VStack(alignment: .leading) {
                if let subtitle {
                    Text(subtitle)
                        .font(.footnote)
                }
                if let title {
                    Text(title)
                        .font(.headline)
                }
            }
        }
    }
}

#Preview {
    DeliverableSelector(
        sfSymbol: "paintpalette.fill",
        title: "Colors",
        subtitle: "Phase 7, Deliverable 2"
    )
}

#Preview("No title") {
    DeliverableSelector(
        sfSymbol: "star.fill",
        subtitle: "This is DeliverableSelector without title"
    )
}
