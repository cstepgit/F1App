//
//  F1TabView.swift
//  F1
//
//  Created by Cooper Stepanian on 4/20/25.
//

import SwiftUI

struct F1TabView: View {
    var body: some View {
        TabView {
            ConstructorsListView()
                .tabItem {
                    Label("Standings", systemImage: "trophy")

                }
            

        }
    }
}

#Preview {
    F1TabView()
}
