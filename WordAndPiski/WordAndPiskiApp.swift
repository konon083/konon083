import SwiftUI

@main
struct WordAndPiskiApp: App {
    @StateObject private var prefs = Prefs()
    @StateObject private var sound = SoundPlayer()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(prefs)
                .environmentObject(sound)
        }
    }
}
