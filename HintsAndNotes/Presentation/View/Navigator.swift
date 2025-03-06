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
        case dashboard
        case addLabel
        case settings
    }

    var path = NavigationPath()

    func popToRoot() {
        path = NavigationPath()
    }

    func showView(for route: Routes) -> some View {
        path.append(route)
        return destination(for: route)
    }

    @ViewBuilder
    func destination(for route: Routes) -> some View {
        switch route {
        case .dashboard:
            DashboardView()
        case .addLabel:
            CameraView()
        case .settings:
            Text("TODO: Settings View")
        }
    }
}
