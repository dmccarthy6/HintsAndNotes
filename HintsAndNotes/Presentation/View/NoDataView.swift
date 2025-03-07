//
//  NoAvailableLabelsView.swift
//  HintsAndNotes
//
//  Created by Dylan  on 3/6/25.
//

import SwiftUI

struct NoDataView: View {
    @Environment(Navigator.self) var navigator
    let viewModel: DashboardViewModel

    var body: some View {
        VStack {
            Spacer()
            HNTextView(text: viewModel.noLabelsText)
            Spacer()
            HNButton(title: "+",
                     font: .largeTitle) {
                viewModel.showCamera.toggle()
            }
            Spacer()
        }.padding(.horizontal)
    }
}

#Preview {
    NoDataView(viewModel: DashboardViewModel(repo: WineLabelRepo()))
}
