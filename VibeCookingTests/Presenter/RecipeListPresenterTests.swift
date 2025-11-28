//
//  RecipeListPresenterTests.swift
//  VibeCookingTests
//
//  Created by Kanta Oikawa on 2025/07/04.
//

import Dependencies
import Testing

@testable import VibeCooking

@MainActor
struct RecipeListPresenterTests {
    @Test("初期状態が正しいこと")
    func testInitialize() {
        let presenter = RecipeListPresenter()
        #expect(presenter.state.recipes == .idle)
    }

    @Test("onAppearでレシピが取得できること")
    func testOnAppearSuccess() async {
        let presenter = withDependencies {
            $0.recipeRepository.fetchRecipes = {
                Recipe.stubs
            }
        } operation: {
            RecipeListPresenter()
        }
        await presenter.dispatch(.onAppear)
        #expect(presenter.state.recipes == .success(Recipe.stubs))
    }

    @Test("onAppearでレシピの取得に失敗すること")
    func onAppearFailure() async {
        let presenter = withDependencies {
            $0.recipeRepository.fetchRecipes = {
                throw RepositoryError.server(.unauthorized, nil)
            }
        } operation: {
            RecipeListPresenter()
        }
        await presenter.dispatch(.onAppear)
        #expect(presenter.state.recipes == .failure(DomainError(RepositoryError.server(.unauthorized, nil))))
    }
}
