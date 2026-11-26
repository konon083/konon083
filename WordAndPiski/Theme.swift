import SwiftUI

extension Color {
    init(hex: UInt32) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: 1
        )
    }
}

/// Палитра из Android-версии (Material 3). Динамических цветов Material You
/// в iOS нет, поэтому используются статические светлая и тёмная schemes.
struct AppColors {
    let primary: Color
    let onPrimary: Color
    let primaryContainer: Color
    let onPrimaryContainer: Color
    let secondaryContainer: Color
    let onSecondaryContainer: Color
    let tertiaryContainer: Color
    let onTertiaryContainer: Color
    let surfaceVariant: Color
    let onSurfaceVariant: Color

    static let light = AppColors(
        primary: Color(hex: 0x3F51B5),
        onPrimary: .white,
        primaryContainer: Color(hex: 0xDEE0FF),
        onPrimaryContainer: Color(hex: 0x00105C),
        secondaryContainer: Color(hex: 0x6FF7F6),
        onSecondaryContainer: Color(hex: 0x002020),
        tertiaryContainer: Color(hex: 0xFFD9E2),
        onTertiaryContainer: Color(hex: 0x3E001D),
        surfaceVariant: Color(hex: 0xE7E0EC),
        onSurfaceVariant: Color(hex: 0x49454F)
    )

    static let dark = AppColors(
        primary: Color(hex: 0xBBC3FF),
        onPrimary: Color(hex: 0x00208F),
        primaryContainer: Color(hex: 0x293CA0),
        onPrimaryContainer: Color(hex: 0xDEE0FF),
        secondaryContainer: Color(hex: 0x004F50),
        onSecondaryContainer: Color(hex: 0x6FF7F6),
        tertiaryContainer: Color(hex: 0x7B2949),
        onTertiaryContainer: Color(hex: 0xFFD9E2),
        surfaceVariant: Color(hex: 0x49454F),
        onSurfaceVariant: Color(hex: 0xCAC4D0)
    )
}

extension ColorScheme {
    var palette: AppColors {
        self == .dark ? .dark : .light
    }
}
