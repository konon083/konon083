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
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
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
                    VStack(spacing: 12) {
                        Text("ДОБРО ПОЖАЛОВАТЬ!!!")
                            .font(.title2)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)

                        Spacer().frame(height: 12)

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
                            Label {
                                Text("НАЖМИ!!!").fontWeight(.bold)
                            } icon: {
                                Image(systemName: "hand.thumbsup.fill")
                            }
                            .frame(maxWidth: .infinity, minHeight: 56)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(palette.primary)
                        .foregroundStyle(palette.onPrimary)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity, minHeight: geo.size.height)
                }
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
            HStack(spacing: 12) {
                Image(systemName: systemImage)
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, minHeight: 56, alignment: .leading)
            .background(container.opacity(0.95))
            .foregroundStyle(content)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .buttonStyle(.plain)
    }
}
