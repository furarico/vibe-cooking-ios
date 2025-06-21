# CLAUDE.md

このファイルは、このリポジトリのコードを扱う際のClaude Code (claude.ai/code)に対するガイダンスを提供します。

## ビルドコマンド

- アプリをビルド: `xcodebuild -project VibeCooking.xcodeproj -scheme VibeCooking -configuration Debug build`
- ユニットテストを実行: `xcodebuild test -project VibeCooking.xcodeproj -scheme VibeCooking -destination 'platform=iOS Simulator,name=iPhone 15,OS=latest'`
- UIテストを実行: `xcodebuild test -project VibeCooking.xcodeproj -scheme VibeCooking -destination 'platform=iOS Simulator,name=iPhone 15,OS=latest' -only-testing:VibeCookingUITests`

## アーキテクチャ

VibeCookingは、iOS、macOS、visionOSをサポートするマルチプラットフォームのSwiftUIアプリです。プロジェクトは以下を使用しています：

- **SwiftUI**: メインUIフレームワーク
- **Swift Testing**: ユニットテスト用（新しいSwift Testingフレームワークを使用、XCTestではない）
- **マルチプラットフォームターゲット**: iOS 18.5+、macOS 15.5+、visionOS 2.5+をサポート

## プロジェクト構造

- `VibeCooking/`: メインアプリターゲットのソースコード
- `VibeCookingTests/`: Swift Testingフレームワークを使用したユニットテスト
- `VibeCookingUITests/`: UIテスト
- `VibeCooking.xcodeproj/`: Xcodeプロジェクトファイル

## 開発ノート

- アプリは開発チームID `4YP7SQBLYV`で自動コード署名を使用
- バンドル識別子: `co.furari.VibeCooking`
- アプリサンドボックスが有効で、読み取り専用ファイルアクセス権限を持つ
- SwiftUIプレビューが開発用に有効