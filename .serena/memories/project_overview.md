# VibeCooking iOS - Project Overview

## Purpose
VibeCooking is an iOS cooking app built with SwiftUI. It features:
- Recipe browsing and detail views
- Step-by-step cooking instructions with progress tracking
- Voice command support via speech recognition
- Cooking timers
- Lottie animations (speaking/listening states)
- watchOS companion app
- Firebase integration (App Check)

## Tech Stack
- **Language**: Swift
- **UI**: SwiftUI
- **Platform**: iOS + watchOS
- **Build**: Xcode project (`VibeCooking.xcodeproj`)
- **Backend**: OpenAPI-generated API client
- **Firebase**: App Check, analytics
- **Animations**: Lottie
- **CI/CD**: Fastlane (via Bundler/Ruby)
- **Task Runner**: Taskfile (go-task)
- **Tool Management**: mise (ruby 4.0, go-task)

## Architecture (MVP-like with Presenter pattern)
- **Entity/**: Domain models (Recipe, Ingredient, Instruction, CookingTimer, VoiceCommand, etc.)
- **Presenter/**: Presenters conforming to `PresenterProtocol` (state + dispatch pattern)
- **Screen/**: SwiftUI screen views (ContentScreen, RecipeListScreen, RecipeDetailScreen, CookingScreen, etc.)
- **Component/**: Reusable SwiftUI UI components
- **Service/**: Business logic layer
- **Repository/**: Data access layer (API, local storage, speech recognition, audio, timer)
- **Helper/**: Utility helpers (UserDefaults, SpeechRecognition, AudioPlayer)
- **Utility/**: Infrastructure (APIClient, AuthMiddleware, Logger, Collection extensions)
- **OpenAPI/**: OpenAPI spec and generator config
- **Resource/**: Lottie JSON animations

## Key Patterns
- `PresenterProtocol`: defines `state` (Observable) and `dispatch(_:)` for actions
- Presenters are `@Observable` classes with an `Action` enum
- Screens receive presenters and render based on state
- Light mode is enforced app-wide (`.preferredColorScheme(.light)`)
