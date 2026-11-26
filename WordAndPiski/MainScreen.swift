import SwiftUI

struct MainScreen: View {
    @EnvironmentObject private var prefs: Prefs
    @EnvironmentObject private var sound: SoundPlayer
    @Environment(\.colorScheme) private var colorScheme

    let onNavigate: (Route) -> Void

    private var palette: AppColors { colorScheme.palette }

    var body: some View {
        ZStack {
            Image(prefs.altWallpaper ? "bg_alt" : "bg_main")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            // Затемнение, чтобы текст и кнопки читались на любой картинке.
            LinearGradient(
                colors: [Color.black.opacity(0.15), Color.black.opacity(0.6)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            GeometryReader { geo in
                ScrollView {
                    VStack(spacing: 10) {
                        Text("ДОБРО ПОЖАЛОВАТЬ!!!")
                            .font(.title2)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .padding(.top, 4)

                        MenuButton(title: "БЛОКНОТ", systemImage: "square.and.pencil",
                                   container: palette.primaryContainer,
                                   content: palette.onPrimaryContainer) {
                            onNavigate(.notepad)
                        }
                        MenuButton(title: "ПОТОМ!!!", systemImage: "exclamationmark.triangle.fill",
                                   container: palette.tertiaryContainer,
                                   content: palette.onTertiaryContainer) {
                            sound.play(.sndWindowsError)
                        }
                        MenuButton(title: "КОТИКИ", systemImage: "heart.fill",
                                   container: palette.secondaryContainer,
                                   content: palette.onSecondaryContainer) {
                            onNavigate(.cats)
                        }
                        MenuButton(title: "ЗВУКИ!", systemImage: "play.fill",
                                   container: palette.surfaceVariant,
                                   content: palette.onSurfaceVariant) {
                            onNavigate(.sounds)
                        }
                        MenuButton(title: "НАСТРОЙКИ", systemImage: "gearshape.fill",
                                   container: palette.primaryContainer,
                                   content: palette.onPrimaryContainer) {
                            sound.play(.sndSettings)
                            onNavigate(.settings)
                        }
                        MenuButton(title: "О ПРИЛОЖЕНИИ", systemImage: "info.circle.fill",
                                   container: palette.secondaryContainer,
                                   content: palette.onSecondaryContainer) {
                            onNavigate(.about)
                        }

                        Button {
                            sound.play(.sndPress)
                        } label: {
                            HStack(spacing: 10) {
                                Image(systemName: "hand.thumbsup.fill")
                                    .frame(width: 24)
                                Text("НАЖМИ!!!")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.75)
                                Spacer(minLength: 0)
                            }
                            .padding(.horizontal, 14)
                            .frame(height: 52)
                            .frame(maxWidth: .infinity)
                            .background(palette.primary)
                            .foregroundStyle(palette.onPrimary)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        .buttonStyle(.plain)
                    }
                    // На iOS 15 maxWidth: .infinity внутри ScrollView может дать
                    // контент шире экрана. Задаём ширину явно.
                    .frame(width: max(0, geo.size.width - 32))
                    .padding(.vertical, 12)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
        }
    }
}

private struct MenuButton: View {
    let title: String
    let systemImage: String
    let container: Color
    let content: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Image(systemName: systemImage)
                    .frame(width: 24)
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                Spacer(minLength: 0)
            }
            .padding(.horizontal, 14)
            .frame(height: 52)
            .frame(maxWidth: .infinity)
            .background(container.opacity(0.95))
            .foregroundStyle(content)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .buttonStyle(.plain)
    }
}
