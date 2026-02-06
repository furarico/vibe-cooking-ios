# Suggested Commands

## Development
- `task install` — Install Ruby/Fastlane dependencies (`bundle install`)
- `task test` — Run tests via Fastlane (`bundle exec fastlane test`)
- `task` — List all available tasks

## Fastlane
- `bundle exec fastlane test` — Run tests using Scan

## Testing
- Tests are located in `VibeCookingTests/` (Presenter tests)
- Test runner: Fastlane Scan (xcodebuild under the hood)

## Tool Management
- `mise install` — Install tools defined in `mise.toml` (ruby 4.0, go-task)

## System Utilities (macOS/Darwin)
- `git`, `ls`, `find`, `grep` — Standard Unix tools (macOS versions)
- `xcodebuild` — Xcode CLI for building/testing
- `xcrun` — Xcode toolchain runner
