//
//  ConstructorsListView.swift
//  F1
//
//  Created by Cooper Stepanian on 4/20/25.
//

import SwiftUI

struct DriversListView: View {
    @StateObject private var vm = DriversViewModel()
    
    var body: some View {
        NavigationView {
            List(vm.topDrivers, id: \.driver.driverId) { standing in
                HStack(spacing: 16) {
                    Image(systemName: "trophy.fill")
                        .foregroundColor(trophyColor(for: Int(standing.position) ?? 0))
                        .font(.system(size: 24))
                    VStack(alignment: .leading, spacing: 4) {
                        Text(standing.driver.givenName)
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
            vm.fetchDriverStandings()
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
    DriversListView()
}


