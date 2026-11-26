import Foundation
import SwiftUI

/// Простое хранилище: текст блокнота и выбор обоев.
final class Prefs: ObservableObject {
    private let defaults = UserDefaults.standard

    @Published var note: String {
        didSet { defaults.set(note, forKey: "note") }
    }

    @Published var altWallpaper: Bool {
        didSet { defaults.set(altWallpaper, forKey: "alt_wallpaper") }
    }

    init() {
        note = defaults.string(forKey: "note") ?? ""
        altWallpaper = defaults.bool(forKey: "alt_wallpaper")
    }
}
