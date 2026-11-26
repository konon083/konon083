import AVFoundation
import Foundation
import SwiftUI

enum Sound: String {
    case sndBurp = "snd_burp"
    case sndDoorbell = "snd_doorbell"
    case sndMeow = "snd_meow"
    case sndPress = "snd_press"
    case sndSave = "snd_save"
    case sndSettings = "snd_settings"
    case sndSound1 = "snd_sound1"
    case sndSound2 = "snd_sound2"
    case sndSound3 = "snd_sound3"
    case sndWindowsError = "snd_windows_error"
}

/// Проигрывает один звук за раз: новый звук обрывает предыдущий.
final class SoundPlayer: ObservableObject {
    @Published private(set) var isPlaying = false

    private var player: AVAudioPlayer?

    func play(_ sound: Sound) {
        stop()

        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: "mp3") else {
            print("Звук не найден: \(sound.rawValue)")
            return
        }

        // Как на Android: звук играет даже при включённом беззвучном режиме.
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try? AVAudioSession.sharedInstance().setActive(true)

        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            self.player = player
            isPlaying = true
            player.play()
        } catch {
            print("Ошибка воспроизведения: \(error)")
        }
    }

    func stop() {
        player?.stop()
        player = nil
        isPlaying = false
    }

    deinit {
        stop()
    }
}
