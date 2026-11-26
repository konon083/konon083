import Foundation
import SwiftUI

enum Route: Hashable {
    case main
    case notepad
    case cats
    case sounds
    case about
    case settings
}

struct RootView: View {
    @State private var path: [Route] = []

    var body: some View {
        NavigationStack(path: $path) {
            MainScreen { route in
                path.append(route)
            }
            .navigationDestination(for: Route.self) { route in
                destination(for: route)
            }
        }
    }

    @ViewBuilder
    private func destination(for route: Route) -> some View {
        switch route {
        case .main:
            MainScreen { path.append($0) }
        case .notepad:
            NotepadScreen()
        case .cats:
            CatsScreen()
        case .sounds:
            SoundsScreen()
        case .about:
            AboutScreen()
        case .settings:
            SettingsScreen {
                // В Android это finishAffinity(). Публичного API «закрыть приложение»
                // у iOS нет, поэтому здесь используется exit(0).
                exit(0)
            }
        }
    }
}
