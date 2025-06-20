//
//  Environment.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import Foundation

protocol EnvironmentProtocol: Actor {
    static var shared: Self { get }

    var appCheckRepository: AppCheckRepositoryProtocol { get }
    var audioRepository: AudioRepositoryProtocol { get }
    var recipeRepository: RecipeRepositoryProtocol { get }
    var speechRecognitionRepository: SpeechRecognitionRepositoryProtocol { get }
}

final actor EnvironmentImpl: EnvironmentProtocol {
    static let shared: EnvironmentImpl = .init()

    let appCheckRepository: any AppCheckRepositoryProtocol
    let audioRepository: any AudioRepositoryProtocol
    let recipeRepository: any RecipeRepositoryProtocol
    let speechRecognitionRepository: any SpeechRecognitionRepositoryProtocol

    init(
        appCheckRepository: any AppCheckRepositoryProtocol = AppCheckRepositoryImpl(),
        audioRepository: any AudioRepositoryProtocol = AudioRepositoryImpl(),
        recipeRepository: any RecipeRepositoryProtocol = RecipeRepositoryImpl(),
        speechRecognitionRepository: any SpeechRecognitionRepositoryProtocol = SpeechRecognitionRepositoryImpl()
    ) {
        self.appCheckRepository = appCheckRepository
        self.audioRepository = audioRepository
        self.recipeRepository = recipeRepository
        self.speechRecognitionRepository = speechRecognitionRepository
    }
}
