//
//  NoAvailableLabelsView.swift
//  HintsAndNotes
//
//  Created by Dylan  on 3/6/25.
//

import SwiftUI

struct NoAvailableLabelsView: View {
    let viewModel: DashboardViewModel

    var body: some View {
        VStack {
            HNTextView(text: viewModel.noLabelsText)
            Spacer()
            AddWineButton {
                viewModel.showCamera.toggle()
            }
            .padding(.horizontal)
        }
        .navigationBar(title: "My Labels",
                       leadingAction: {
            print("Show Settings ")
        }, trailingAction: {
            viewModel.showCamera.toggle()
        })
    }
}

#Preview {
    NoAvailableLabelsView(viewModel: DashboardViewModel(repo: WineLabelRepo()))
}
