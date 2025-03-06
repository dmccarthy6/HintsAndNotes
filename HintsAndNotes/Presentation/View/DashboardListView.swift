//
//  DashboardListView.swift
//  HintsAndNotes
//
//  Created by Dylan  on 3/6/25.
//

import SwiftUI

struct DashboardListView: View {
    let viewModel: DashboardViewModel

    var body: some View {
        List(viewModel.allWines, id: \.id) { wine in
            LabelRow(name: wine.name, type: wine.type, image: nil)
                .onTapGesture {
                    viewModel.selectedWine = wine.id
                }
        }
        .listStyle(.plain)
        .navigationTitle("My Labels")
    }
}

#Preview {
    DashboardListView(viewModel: DashboardViewModel(repo: WineLabelRepo()))
}
