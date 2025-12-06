//
//  ContentPresenterTests.swift
//  VibeCookingTests
//
//  Created by Kanta Oikawa on 2025/12/06.
//

import Dependencies
import Testing

@testable import VibeCooking

@MainActor
struct ContentPresenterTests {
    @Test("初期状態が正しいこと")
    func testInitialize() {
        let presenter = ContentPresenter()

        #expect(presenter.state.isVibeCookingListPresented == false)
        #expect(presenter.state.isVibeCookingPresented == false)
        #expect(presenter.state.vibeCookingListRecipeIDs.isEmpty)
    }

    @Test("Vibe Cooking リストボタンがタップされたときに Vibe Cooking リストが表示されること")
    func testOnVibeCookingListButtonTapped() async throws {
        let presenter = ContentPresenter()

        #expect(presenter.state.isVibeCookingListPresented == false)

        await presenter.dispatch(.onVibeCookingListButtonTapped)

        #expect(presenter.state.isVibeCookingListPresented == true)
    }

    @Test("Vibe Cooking スタートボタンがタップされたときに Vibe Cooking がスタートすること")
    func testOnStartVibeCookingButtonTappedSuccess() async throws {
        let recipeIDs = Recipe.stubs.map(\.id)

        let presenter = withDependencies {
            $0.localRepository.removeVibeCookingList = {
            }
        } operation: {
            ContentPresenter()
        }

        #expect(presenter.state.isVibeCookingPresented == false)
        #expect(presenter.state.vibeCookingListRecipeIDs.isEmpty)

        await presenter.dispatch(.onStartVibeCookingButtonTapped(recipeIDs: recipeIDs))

        #expect(presenter.state.isVibeCookingListPresented == false)
        #expect(presenter.state.isVibeCookingPresented == true)
        #expect(presenter.state.vibeCookingListRecipeIDs == recipeIDs)
    }

    @Test("Vibe Cooking リストのクリアに失敗した時に状態が変化しないこと")
    func testOnStartVibeCookingButtonTappedFailure() async throws {
        let recipeIDs = Recipe.stubs.map(\.id)

        let presenter = withDependencies {
            $0.localRepository.removeVibeCookingList = {
                throw RepositoryError.unknown(nil)
            }
        } operation: {
            ContentPresenter()
        }

        #expect(presenter.state.isVibeCookingPresented == false)
        #expect(presenter.state.vibeCookingListRecipeIDs.isEmpty)

        await presenter.dispatch(.onStartVibeCookingButtonTapped(recipeIDs: recipeIDs))

        #expect(presenter.state.isVibeCookingPresented == false)
        #expect(presenter.state.vibeCookingListRecipeIDs.isEmpty)
    }
}
