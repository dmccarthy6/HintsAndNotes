//
//  DashboardView.swift
//  HintsAndNotes
//
//  Created by Dylan  on 3/4/25.
//

import SwiftUI

struct DashboardView: View {
    @State var viewModel = DashboardViewModel(repo: WineLabelRepo())
    @State private var navigator = Navigator()

    var body: some View {
        NavigationStack(path: $navigator.path) {
            if !viewModel.allWines.isEmpty {
                DashboardListView(viewModel: viewModel)
            } else {
                NoAvailableLabelsView(viewModel: viewModel)
            }
        }
        .navigationDestination(for: Navigator.Routes.self, destination: { route in
            navigator.showView(for: route)
        })
        .task {
            viewModel.getWines()
        }
        .sheet(isPresented: $viewModel.showCamera) {
            NavigationView {
                CameraView()
            }
        }
    }
}

#Preview {
    DashboardView()
}
