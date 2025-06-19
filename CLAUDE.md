# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build Commands

- Build the app: `xcodebuild -project VibeCooking.xcodeproj -scheme VibeCooking -configuration Debug build`
- Run unit tests: `xcodebuild test -project VibeCooking.xcodeproj -scheme VibeCooking -destination 'platform=iOS Simulator,name=iPhone 15,OS=latest'`
- Run UI tests: `xcodebuild test -project VibeCooking.xcodeproj -scheme VibeCooking -destination 'platform=iOS Simulator,name=iPhone 15,OS=latest' -only-testing:VibeCookingUITests`

## Architecture

VibeCooking is a multi-platform SwiftUI app supporting iOS, macOS, and visionOS. The project uses:

- **SwiftUI**: Main UI framework
- **Swift Testing**: For unit tests (using the new Swift Testing framework, not XCTest)
- **Multi-platform targets**: Supports iOS 18.5+, macOS 15.5+, visionOS 2.5+

## Project Structure

- `VibeCooking/`: Main app target source code
- `VibeCookingTests/`: Unit tests using Swift Testing framework
- `VibeCookingUITests/`: UI tests
- `VibeCooking.xcodeproj/`: Xcode project file

## Development Notes

- The app uses automatic code signing with development team ID `4YP7SQBLYV`
- Bundle identifier: `co.furari.VibeCooking`
- App sandbox is enabled with read-only file access permissions
- SwiftUI previews are enabled for development