# WordAndPiski (iOS / SwiftUI)

Порт Android-приложения `WordAndPiski_Material3` на SwiftUI.

## Что перенесено

- Главный экран с двумя обоями и всеми кнопками.
- Блокнот с сохранением в `UserDefaults`.
- Экраны «КОТИКИ», «ЗВУКИ!», «О ПРИЛОЖЕНИИ», «НАСТРОЙКИ».
- Все 10 mp3-звуков и все изображения из Android-проекта.
- Палитра Material 3 (светлая и тёмная темы).
- Настройка «КРАШ» (использует `exit(0)`; для App Store такое поведение нужно убрать).

## Сборка

Собрать `.ipa` можно только на macOS с Xcode 13+:

1. Откройте `WordAndPiski.xcodeproj` в Xcode.
2. Выберите target **WordAndPiski** → Signing & Capabilities → укажите свой **Team**.
3. Выберите simulator или своё устройство и нажмите **⌘R**.
4. Для `.ipa`: Product → Archive → Distribute App.

Минимальная версия iOS: **15.0** (навигация через `NavigationView`, без `NavigationStack`).
Bundle ID: `com.example.wordandpiski`, версия `4.0` (467).

## Отличия от Android-версии

- Динамические цвета Material You (Android 12+) заменены статическими палитрами.
- Material-иконки заменены на SF Symbols.
- Системная кнопка «назад» заменена стрелкой `chevron.left` в стиле Android.
- `finishAffinity()` заменён на `exit(0)`, так как публичного API закрытия приложения в iOS нет.

## Структура

```
WordAndPiski-iOS/
├── WordAndPiski.xcodeproj/
│   └── project.pbxproj
├── WordAndPiski/
│   ├── WordAndPiskiApp.swift
│   ├── RootView.swift
│   ├── MainScreen.swift
│   ├── Screens.swift
│   ├── SoundPlayer.swift
│   ├── Prefs.swift
│   ├── Theme.swift
│   ├── Assets.xcassets/
│   └── Sounds/
└── README.md
```
