//
//  Navigator.swift
//  HintsAndNotes
//
//  Created by Dylan  on 3/6/25.
//

import SwiftUI

@Observable
class Navigator {
    enum Routes {
        case addLabel
        case camera
        case dashboard
        case settings
    }

    var path = NavigationPath()

    func popToRoot() {
        path = NavigationPath()
    }

    func navigate(to route: Routes) {
        path.append(route)
    }

    @ViewBuilder
    func destination(for route: Routes) -> some View {
        switch route {
        case .addLabel: WineLabelView()
        case .camera: CameraView()
        case .dashboard: DashboardView()
        case .settings: Text("TODO: Settings View")
        }
    }
}
