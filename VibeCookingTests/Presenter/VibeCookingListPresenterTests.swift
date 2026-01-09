//
//  VibeCookingListPresenterTests.swift
//  VibeCookingTests
//
//  Created by Kanta Oikawa on 2025/12/06.
//

import Dependencies
import Foundation
import Testing

@testable import VibeCooking

@MainActor
struct VibeCookingListPresenterTests {
    @Test("初期状態が正しいこと")
    func testInitialize() {
        let presenter = VibeCookingListPresenter()
        #expect(presenter.state.recipes == .idle)
    }

    @Test("onAppear でバイブレシピが取得できること (空)")
    func testSetNothingSuccessfullyOnAppear() async {
        let recipeIDs: [Recipe.ID] = []
        let recipes: [Recipe] = []

        let presenter = withDependencies {
            $0.localRepository.getVibeCookingList = {
                recipeIDs
            }
            $0.recipeRepository.fetchRecipes = { _, _ in
                recipes
            }
        } operation: {
            VibeCookingListPresenter()
        }

        await presenter.dispatch(.onAppear)

        #expect(presenter.state.recipes == .success(recipes))
    }

    @Test("onAppear でバイブレシピが取得できること (3レシピ)")
    func testSetVibeRecipeSuccessfullyOnAppear() async {
        let recipeIDs = Array(Recipe.stubs.map(\.id).prefix(upTo: 3))
        let recipes = Recipe.stubs.filter { recipe in
            recipeIDs.contains(recipe.id)
        }

        let presenter = withDependencies {
            $0.localRepository.getVibeCookingList = {
                recipeIDs
            }
            $0.recipeRepository.fetchRecipes = { _, _ in
                recipes
            }
        } operation: {
            VibeCookingListPresenter()
        }

        await presenter.dispatch(.onAppear)

        #expect(presenter.state.recipes == .success(recipes))
    }

    @Test("onAppear でバイブレシピの取得に失敗すること")
    func testSetVibeRecipeUnsuccessfullyOnAppear() async {
        let recipeIDs: [Recipe.ID] = []
        let repositoryError = RepositoryError.server(.serviceUnavailable, nil)

        let presenter = withDependencies {
            $0.localRepository.getVibeCookingList = {
                recipeIDs
            }
            $0.recipeRepository.fetchRecipes = { _, _ in
                throw repositoryError
            }
        } operation: {
            VibeCookingListPresenter()
        }

        await presenter.dispatch(.onAppear)

        #expect(presenter.state.recipes == .failure(.init(repositoryError)))
    }

    @Test("onDelete でリストからレシピが削除されること")
    func testRemovedRecipeFromListSuccessfullyOnDelete() async {
        let recipeIDs = Array(Recipe.stubs.map(\.id).prefix(upTo: 3))
        let recipes = Recipe.stubs.filter { recipe in
            recipeIDs.contains(recipe.id)
        }
        let removedRecipeIndexSet: IndexSet = [1]
        var recipesAfterRemove = recipes
        recipesAfterRemove.remove(atOffsets: removedRecipeIndexSet)

        let presenter = withDependencies {
            $0.localRepository.getVibeCookingList = {
                recipeIDs
            }
            $0.localRepository.setVibeCookingList = { _ in
            }
            $0.recipeRepository.fetchRecipes = { _, _ in
                recipes
            }
        } operation: {
            VibeCookingListPresenter()
        }

        await presenter.dispatch(.onAppear)

        #expect(presenter.state.recipes == .success(recipes))

        await presenter.dispatch(.onDelete(offsets: removedRecipeIndexSet))

        #expect(presenter.state.recipes == .success(recipesAfterRemove))
    }

    @Test("onDelete で Vibe Cooking リストの更新に失敗した時に状態が変化しないこと")
    func testRemovedRecipeFromListUnsuccessfullyOnDelete() async {
        let recipeIDs = Array(Recipe.stubs.map(\.id).prefix(upTo: 3))
        let recipes = Recipe.stubs.filter { recipe in
            recipeIDs.contains(recipe.id)
        }
        let removedRecipeIndexSet: IndexSet = [1]

        let presenter = withDependencies {
            $0.localRepository.getVibeCookingList = {
                recipeIDs
            }
            $0.localRepository.setVibeCookingList = { _ in
                throw RepositoryError.unknown(nil)
            }
            $0.recipeRepository.fetchRecipes = { _, _ in
                recipes
            }
        } operation: {
            VibeCookingListPresenter()
        }

        await presenter.dispatch(.onAppear)

        #expect(presenter.state.recipes == .success(recipes))

        await presenter.dispatch(.onDelete(offsets: removedRecipeIndexSet))

        #expect(presenter.state.recipes == .success(recipes))
    }
}
