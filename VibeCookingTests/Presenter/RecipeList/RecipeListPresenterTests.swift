//
//  RecipeListPresenterTests.swift
//  VibeCookingTests
//
//  Created by Kanta Oikawa on 2025/07/04.
//

import Testing

@testable import VibeCooking

@MainActor
struct RecipeListPresenterTests {
    @Test("初期状態が正しいこと")
    func initialState() {
        let presenter = RecipeListPresenter<MockEnvironment>()
        #expect(presenter.state.recipes == .idle)
    }

    @Test("onAppearでレシピが取得できること")
    func onAppearSuccess() async {
        let presenter = RecipeListPresenter<MockEnvironment>()
        await presenter.dispatch(.onAppear)
        #expect(presenter.state.recipes == .success(Components.Schemas.Recipe.stubs))
    }
}
