# Code Style & Conventions

## Swift Style
- Standard Swift naming conventions (camelCase for variables/functions, PascalCase for types)
- File header comments with file name, project name, author, and date
- SwiftUI views as structs
- `@Observable` macro for presenters (not ObservableObject)
- `@UIApplicationDelegateAdaptor` for Firebase setup

## Architecture Conventions
- **Presenter pattern**: Each screen has a corresponding Presenter class
  - Conforms to `PresenterProtocol`
  - Has a nested `Action` enum for all user actions
  - `state` property holds the view state
  - `dispatch(_:)` method handles actions (sync and async variants)
- **Screen**: SwiftUI View that takes a Presenter, renders based on state
- **Component**: Reusable SwiftUI views (no business logic)
- **Service**: Business logic, used by Presenters
- **Repository**: Data access (API calls, local storage, hardware access)
- **Entity**: Plain data models (structs, typically Codable/Identifiable)
- **Helper**: Thin wrappers around system APIs

## File Organization
- One type per file (named after the type)
- Grouped by layer (Entity, Presenter, Screen, Component, Service, Repository, Helper, Utility)
