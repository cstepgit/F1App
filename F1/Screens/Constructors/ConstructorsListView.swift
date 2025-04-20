//
//  ConstructorsListView.swift
//  F1
//
//  Created by Cooper Stepanian on 4/20/25.
//

import SwiftUI

struct ConstructorsListView: View {
    @StateObject private var vm = ConstructorsViewModel()
    
    var body: some View {
        NavigationView {
            List(vm.topConstructors, id: \.constructor.constructorId) { standing in
                HStack(spacing: 16) {
                    Image(systemName: "trophy.fill")
                        .foregroundColor(trophyColor(for: Int(standing.position)))
                        .font(.system(size: 24))
                    VStack(alignment: .leading, spacing: 4) {
                        Text(standing.constructor.name)
                            .font(.headline)
                        Text("\(standing.points) Points")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
        
        }
            .navigationTitle("Constructor Standings")
            .listStyle(.plain)
    }
        .onAppear {
            vm.fetchConstructorStandings()
        }
}

    private func trophyColor(for position: Int) -> Color {
        switch position {
        case 1: return .yellow     // Gold
        case 2: return .gray       // Silver
        case 3: return .orange     // Bronze
        default: return .secondary
        }
    }
}

#Preview {
    ConstructorsListView()
}

