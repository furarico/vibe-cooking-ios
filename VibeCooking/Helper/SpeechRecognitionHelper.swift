//
//  SpeechRecognitionHelper.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/11/26.
//

import Speech

final actor SpeechRecognitionHelper {

    private var audioEngine: AVAudioEngine?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?
    private let recognizer: SFSpeechRecognizer?
    private var transcriptionContinuation: AsyncStream<TranscriptionResult>.Continuation?

    /**
     Initializes a new speech recognizer. If this is the first time you've used the class, it
     requests access to the speech recognizer and the microphone.
     */
    init() {
        recognizer = SFSpeechRecognizer(locale: .current)
    }

    func startTranscribing() -> AsyncStream<TranscriptionResult> {
        AsyncStream { continuation in
            self.transcriptionContinuation = continuation

            Task {
                guard let recognizer = recognizer else {
                    continuation.yield(TranscriptionResult.failure(SpeechRecognitionRepositoryError.nilRecognizer))
                    continuation.finish()
                    return
                }

                guard await SFSpeechRecognizer.hasAuthorizationToRecognize() else {
                    continuation.yield(TranscriptionResult.failure(SpeechRecognitionRepositoryError.notAuthorizedToRecognize))
                    continuation.finish()
                    return
                }

                guard await AVAudioSession.sharedInstance().hasPermissionToRecord() else {
                    continuation.yield(TranscriptionResult.failure(SpeechRecognitionRepositoryError.notPermittedToRecord))
                    continuation.finish()
                    return
                }

                transcribe(recognizer: recognizer)
            }

            continuation.onTermination = { @Sendable _ in
                Task {
                    await self.reset()
                }
            }
        }
    }

    func stopTranscribing() {
        transcriptionContinuation?.finish()
        transcriptionContinuation = nil
        reset()
    }

    /**
     Begin transcribing audio.

     Creates a `SFSpeechRecognitionTask` that transcribes speech to text until you call `stopTranscribing()`.
     The resulting transcription is continuously written to the AsyncStream.
     */
    private func transcribe(recognizer: SFSpeechRecognizer) {
        guard recognizer.isAvailable else {
            transcriptionContinuation?.yield(TranscriptionResult.failure(SpeechRecognitionRepositoryError.recognizerIsUnavailable))
            transcriptionContinuation?.finish()
            return
        }

        do {
            let (audioEngine, request) = try Self.prepareEngine()
            self.audioEngine = audioEngine
            self.request = request
            self.task = recognizer.recognitionTask(with: request, resultHandler: recognitionHandler)
        } catch {
            self.reset()
            transcriptionContinuation?.yield(TranscriptionResult.failure(error))
            transcriptionContinuation?.finish()
        }
    }

    /// Reset the speech recognizer.
    private func reset() {
        task?.cancel()
        audioEngine?.stop()
        audioEngine = nil
        request = nil
        task = nil
    }

    private static func prepareEngine() throws -> (AVAudioEngine, SFSpeechAudioBufferRecognitionRequest) {
        let audioEngine = AVAudioEngine()

        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true

        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.playAndRecord, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            request.append(buffer)
        }
        audioEngine.prepare()
        try audioEngine.start()

        return (audioEngine, request)
    }

    private func recognitionHandler(result: SFSpeechRecognitionResult?, error: Error?) {
        let receivedFinalResult = result?.isFinal ?? false
        let receivedError = error != nil

        if receivedFinalResult || receivedError {
            audioEngine?.stop()
            audioEngine?.inputNode.removeTap(onBus: 0)
        }

        if let result {
            let transcriptionResult = TranscriptionResult.success(result.bestTranscription.formattedString)
            transcriptionContinuation?.yield(transcriptionResult)
        }

        if let error = error {
            let transcriptionResult = TranscriptionResult.failure(error)
            transcriptionContinuation?.yield(transcriptionResult)
        }

        if receivedFinalResult || receivedError {
            transcriptionContinuation?.finish()
        }
    }
}

extension SFSpeechRecognizer {
    static func hasAuthorizationToRecognize() async -> Bool {
        await withCheckedContinuation { continuation in
            requestAuthorization { status in
                continuation.resume(returning: status == .authorized)
            }
        }
    }
}

extension AVAudioSession {
    func hasPermissionToRecord() async -> Bool {
        await withCheckedContinuation { continuation in
            AVAudioApplication.requestRecordPermission { authorized in
                continuation.resume(returning: authorized)
            }
        }
    }
}
