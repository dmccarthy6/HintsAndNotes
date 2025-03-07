//
//  DashboardListView.swift
//  HintsAndNotes
//
//  Created by Dylan  on 3/6/25.
//

import SwiftUI

struct DashboardListView: View {
    private let viewModel: DashboardViewModel

    var body: some View {
        if !viewModel.allWines.isEmpty {
            List(viewModel.allWines, id: \.id) { wine in
                LabelRow(name: wine.name, type: wine.type, image: nil)
                    .onTapGesture {
                        viewModel.selectedWine = wine.id
                    }
            }
            .listStyle(.plain)
        } else {
            NoDataView(viewModel: viewModel)
        }
    }

    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
    }
}

#Preview {
    DashboardListView(viewModel: DashboardViewModel(repo: WineLabelRepo()))
}
