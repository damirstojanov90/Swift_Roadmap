//
//  HomeView.swift
//  SwiftUI Deliverables
//
//  Created by Damir Stojanov on 05.10.2026..
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        /// NavigationSplitView is a multi-column container designed for iPadOS, macOS and large
        /// screen iOS devices (in landscape). Automatically adapts into a compact single-column stack
        /// when rendered on smaller screens.
        ///
        /// NavigationLink items take a destination
        NavigationSplitView {
            List {
                NavigationLink {
                    ListWelcomeView()
                } label: {
                    DeliverableSelector(
                        sfSymbol: "list.bullet.clipboard.fill",
                        title: "List",
                        subtitle: "Phase 7 - Deliverable 1")
                }

                NavigationLink {
                    ColorsView()
                } label: {
                    DeliverableSelector(
                        sfSymbol: "paintpalette.fill",
                        title: "Colors",
                        subtitle: "Phase 7 - Deliverable 2"
                    )
                }
            }
            .navigationTitle("Deliverable Selection")
        } detail: {
                Text("Select a deliverable")
        }
    }
}

#Preview {
    HomeView()
}
