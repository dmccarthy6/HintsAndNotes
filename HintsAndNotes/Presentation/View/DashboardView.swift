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
            DashboardListView(viewModel: viewModel)
                .navigationDestination(for: Navigator.Routes.self, destination: { route in
                    navigator.destination(for: route)
                })
                .navigationBar(title: "My Labels",
                               leadingAction: {
                    print("SHOW SETTINGS")
                }, trailingAction: {
                    viewModel.showCamera = true
                })
        }
        .environment(navigator)
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
