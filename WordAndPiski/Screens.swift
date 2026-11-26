import SwiftUI

/// Общий каркас внутренних экранов: верхняя панель со стрелкой «назад».
private struct SubScreen<Content: View>: View {
    let title: String
    @Environment(\.dismiss) private var dismiss
    @ViewBuilder var content: Content

    var body: some View {
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                }
            }
    }
}

// MARK: - Блокнот

struct NotepadScreen: View {
    @EnvironmentObject private var prefs: Prefs
    @EnvironmentObject private var sound: SoundPlayer
    @State private var text = ""

    var body: some View {
        SubScreen(title: "БЛОКНОТ") {
            ZStack(alignment: .bottomTrailing) {
                TextEditor(text: $text)
                    .font(.system(size: 18))
                    .padding(.horizontal, 8)
                    .overlay(alignment: .topLeading) {
                        if text.isEmpty {
                            Text("Заметка")
                                .foregroundStyle(.secondary)
                                .padding(.top, 8)
                                .padding(.leading, 13)
                                .allowsHitTesting(false)
                        }
                    }

                Button {
                    prefs.note = text
                    sound.play(.sndSave)
                } label: {
                    Label("СОХРАНИТЬ", systemImage: "checkmark")
                        .fontWeight(.bold)
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
        }
        .onAppear { text = prefs.note }
    }
}

// MARK: - Котики

struct CatsScreen: View {
    @EnvironmentObject private var sound: SoundPlayer
    private let cats = ["cat1", "cat2", "cat3"]

    var body: some View {
        SubScreen(title: "КОТИКИ") {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(cats, id: \.self) { name in
                        Button {
                            sound.play(.sndMeow)
                        } label: {
                            Image(name)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity)
                                .aspectRatio(3.0 / 4.0, contentMode: .fill)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 24))
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(16)
            }
        }
    }
}

// MARK: - Звуки

private struct SoundItem: Identifiable {
    let title: String
    let sound: Sound
    var id: String { title }
}

struct SoundsScreen: View {
    @EnvironmentObject private var sound: SoundPlayer
    @Environment(\.colorScheme) private var colorScheme

    private let items: [SoundItem] = [
        SoundItem(title: "НАЧИНАЕТСЯ СЕКС НАСТОЯЩИЙ", sound: .sndSound1),
        SoundItem(title: "СТОН И ФИМОЗ", sound: .sndSound2),
        SoundItem(title: "А ХУЙ ТЕБЕ", sound: .sndSound3),
        SoundItem(title: "ЗВУК ДОМОФОНА", sound: .sndDoorbell),
    ]

    private var palette: AppColors { colorScheme.palette }

    var body: some View {
        SubScreen(title: "ЗВУКИ!") {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(items) { item in
                        Button {
                            sound.play(item.sound)
                        } label: {
                            HStack(spacing: 12) {
                                Image(systemName: "play.fill")
                                Text(item.title)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                            .frame(maxWidth: .infinity, minHeight: 64, alignment: .leading)
                            .background(palette.surfaceVariant)
                            .foregroundStyle(palette.onSurfaceVariant)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(16)
            }
        }
    }
}

// MARK: - О приложении

struct AboutScreen: View {
    @EnvironmentObject private var sound: SoundPlayer
    @State private var burped = false

    var body: some View {
        SubScreen(title: "О ПРИЛОЖЕНИИ") {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 8) {
                        Text("СДЕЛАНО В КИТАЕ ЕПТЭ")
                            .font(.title2)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        Text("ВЕРСИЯ 3.5")
                            .font(.title2)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(20)
                    .background(Color.gray.opacity(0.18))
                    .clipShape(RoundedRectangle(cornerRadius: 24))

                    Text("НАЖМИ НА СТАСА")
                        .font(.headline)
                        .fontWeight(.bold)

                    Button {
                        burped = true
                        sound.play(.sndBurp)
                    } label: {
                        Image(burped ? "stas_burp" : "stas_normal")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 220, height: 220)
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                    }
                    .buttonStyle(.plain)

                    Button("понял...") {
                        burped = false
                    }
                    .buttonStyle(.bordered)
                }
                .padding(16)
            }
        }
    }
}

// MARK: - Настройки

struct SettingsScreen: View {
    @EnvironmentObject private var prefs: Prefs
    @Environment(\.dismiss) private var dismiss
    @State private var crash = false

    let onCrash: () -> Void

    var body: some View {
        SubScreen(title: "НАСТРОЙКИ") {
            List {
                Toggle(isOn: Binding(
                    get: { prefs.altWallpaper },
                    set: { prefs.altWallpaper = $0 }
                )) {
                    SettingLabel(
                        title: "ПОМЕНЯТЬ ОБОИ",
                        subtitle: "Другая картинка на главном экране"
                    )
                }

                Toggle(isOn: Binding(
                    get: { crash },
                    set: { newValue in
                        crash = newValue
                        if newValue { onCrash() }
                    }
                )) {
                    SettingLabel(title: "КРАШ", subtitle: "Закрывает приложение")
                }

                Section {
                    Button {
                        dismiss()
                    } label: {
                        Text("СОХРАНИТЬ")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }
}

private struct SettingLabel: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title).fontWeight(.bold)
            Text(subtitle)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}
