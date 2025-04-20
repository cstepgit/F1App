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
            Group {
                if vm.isLoading {
                    ProgressView("Loading…")
                } else if let error = vm.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                } else {
                    List(vm.constructorStandings, id: \.constructor.constructorId) { standing in
                        HStack {
                            Text("\(standing.position).")
                            Text(standing.constructor.name)
                                .font(.headline)
                            Spacer()
                            Text("\(standing.points) pts")
                        }
                    }
                }
            }
            .navigationTitle("Constructor Standings")
            .onAppear { vm.fetchConstructorStandings() }
        }
    }
}


#Preview {
    ConstructorsListView()
}
