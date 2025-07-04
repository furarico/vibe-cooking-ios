# VibeCooking

[![CI](https://github.com/furarico/vibe-cooking-ios/actions/workflows/ci.yaml/badge.svg)](https://github.com/furarico/vibe-cooking-ios/actions/workflows/ci.yaml)

音声ガイドによるハンズフリー料理体験を提供するiOS/macOS/visionOSアプリ

## 概要

VibeCookingは、**音声コマンドによる料理指導**を中心とした革新的な料理アプリです。複数のレシピを組み合わせて効率的な調理フローを構築し、調理中でも手を汚すことなく音声だけで操作できる「ハンズフリー料理体験」を実現します。

## 主要機能

### 🍳 Vibe Cooking（音声ガイド調理）
- **統合レシピ生成**: 複数のレシピを最適な調理順序に統合
- **音声ガイド**: 各調理手順を音声で案内
- **音声コマンド操作**: 
  - "次" / "つぎ" / "next" → 次の手順へ
  - "前" / "まえ" / "back" → 前の手順へ
  - "もう一度" / "repeat" → 手順の再生
- **ハンズフリー操作**: 調理中でも音声だけで完全操作

### 📝 レシピ管理
- **レシピ一覧**: サーバーから取得したレシピの表示・検索
- **詳細表示**: 材料、手順、調理時間などの詳細情報
- **画像対応**: 各レシピの画像表示（デフォルト画像対応）

### 📋 調理リスト管理
- **複数レシピ選択**: 最大3つまでのレシピを調理リストに追加
- **統合材料表示**: 選択した複数レシピの材料を統合して表示
- **効率的な買い物**: 必要な材料をまとめて確認

### 🎤 高度な音声認識
- **多言語対応**: 日本語・英語の音声コマンド認識
- **リアルタイム処理**: 即座に音声コマンドを判定・実行
- **視覚フィードバック**: マイクアイコンによる認識状態表示

## 技術仕様

### 対応環境
- **iOS**: 18.5以上
- **macOS**: 15.5以上
- **visionOS**: 2.5以上
- **言語**: Swift
- **UIフレームワーク**: SwiftUI

### アーキテクチャ
- **設計パターン**: MVVM + Repository パターン
- **依存性注入**: EnvironmentProtocolによる環境駆動設計
- **並行処理**: Actor-basedによる安全性確保
- **状態管理**: iOS 17+の@Observableマクロを活用

### 主要技術スタック

#### フレームワーク
- **SwiftUI**: メインUIフレームワーク
- **Swift Testing**: ユニットテスト（XCTestではなく新しいテストフレームワーク）
- **SFSpeechRecognizer**: 音声認識
- **AVFoundation**: 音声再生・録音

#### ネットワーク・API
- **OpenAPI Generator**: APIクライアント自動生成
- **swift-openapi-runtime**: OpenAPIランタイム
- **URLSession**: HTTP通信

#### Firebase統合
- **Firebase App Check**: セキュリティ強化
- **Firebase Crashlytics**: クラッシュレポート

## プロジェクト構造

```
VibeCooking/
├── Screen/              # 画面（View）
│   ├── ContentScreen.swift
│   ├── RecipeListScreen.swift
│   ├── RecipeDetailScreen.swift
│   ├── VibeCookingListScreen.swift
│   ├── VibeCookingScreen.swift
│   └── CookingScreen.swift
├── Presenter/           # プレゼンター（ViewModel）
├── Component/           # 再利用可能UIコンポーネント
├── Service/             # ビジネスロジック層
├── Repository/          # データアクセス層
├── Entity/              # データモデル・エンティティ
├── Environment/         # 依存性注入・環境設定
├── SpeechRecognizer/    # 音声認識機能
├── Utility/             # ユーティリティ
├── Mock/                # テスト用モック
└── OpenAPI/             # API仕様・自動生成設定
```

## 開発・ビルド

### 前提条件
- Xcode 16.0以上
- iOS 18.5+ Simulator または実機
- 開発チームID: `4YP7SQBLYV`

### ビルドコマンド

#### アプリのビルド
```bash
xcodebuild -project VibeCooking.xcodeproj -scheme VibeCooking -configuration Debug build
```

#### ユニットテストの実行
```bash
xcodebuild test -project VibeCooking.xcodeproj -scheme VibeCooking -destination 'platform=iOS Simulator,name=iPhone 15,OS=latest'
```

#### UIテストの実行
```bash
xcodebuild test -project VibeCooking.xcodeproj -scheme VibeCooking -destination 'platform=iOS Simulator,name=iPhone 15,OS=latest' -only-testing:VibeCookingUITests
```

### 設定情報
- **バンドル識別子**: `co.furari.VibeCooking`
- **自動コード署名**: 有効
- **アプリサンドボックス**: 有効（読み取り専用ファイルアクセス権限）
- **SwiftUIプレビュー**: 開発用に有効

## 特徴的な実装

### 音声コマンド処理
- 多言語対応のトリガーフレーズ検出
- リアルタイム音声認識とコマンド判定
- 非同期ストリームによる音声イベント処理

### 統合レシピ生成
- 複数レシピの手順を最適な調理順序に統合
- サーバーサイドAPIによる最適化
- 手順の再ステップ化とID管理

### 状態管理
- DataStateパターンによる非同期データ状態管理
- @Observableマクロによるリアクティブな UI更新
- Actor-based並行処理による安全性確保

## 使用方法

1. **レシピ選択**: レシピ一覧から気になるレシピを選択
2. **調理リスト作成**: 最大3つまでのレシピを調理リストに追加
3. **Vibe Cooking開始**: 音声ガイドによる統合調理フローを開始
4. **音声操作**: 調理中は音声コマンドで手順を進行
5. **完成**: 効率的に複数の料理を同時に調理完了

## ライセンス

このプロジェクトのライセンス情報については、プロジェクトオーナーにお問い合わせください。

## 貢献

バグ報告や機能提案は、GitHubのIssuesにてお気軽にお寄せください。