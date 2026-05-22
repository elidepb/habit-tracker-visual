# Habit Tracker Visual

App de seguimiento de hábitos con heatmap estilo GitHub, construida en Flutter.

## Stack

- **Flutter** + **Dart**
- **Riverpod** — gestión de estado
- **GoRouter** — navegación declarativa
- **Google Fonts (Inter)** + **Lucide Icons**

## Arquitectura

Feature-first con capas ligeras:

```text
lib/
├── app.dart
├── main.dart
├── core/
│   ├── router/
│   └── theme/
├── features/
│   ├── splash/
│   ├── onboarding/
│   ├── home/
│   ├── statistics/
│   ├── settings/
│   ├── create_habit/
│   └── habit_detail/
└── shared/
    └── widgets/
```

## Ejecutar

```bash
flutter pub get
flutter run
```

## Plan de desarrollo

Ver [plan.md](plan.md) para el roadmap completo (PR-01 a PR-14).
