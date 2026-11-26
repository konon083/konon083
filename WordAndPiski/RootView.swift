import Foundation
import SwiftUI

enum Route {
    case main
    case notepad
    case cats
    case sounds
    case about
    case settings
}

/// Навигация через NavigationView: совместима с iOS 15.
/// NavigationStack доступен только с iOS 16, поэтому здесь state + NavigationLink.
struct RootView: View {
    @State private var selection: Route? = nil

    var body: some View {
        NavigationView {
            MainScreen { route in
                selection = route
            }
            .background(
                NavigationLink(
                    destination: destination(for: selection ?? .main),
                    isActive: Binding(
                        get: { selection != nil },
                        set: { active in
                            if !active { selection = nil }
                        }
                    )
                ) {
                    EmptyView()
                }
                .frame(width: 0, height: 0)
                .opacity(0)
            )
        }
        .navigationViewStyle(.stack)
    }

    @ViewBuilder
    private func destination(for route: Route) -> some View {
        switch route {
        case .main:
            MainScreen { selection = $0 }
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
