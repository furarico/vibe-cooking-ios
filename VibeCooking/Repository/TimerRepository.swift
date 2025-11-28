//
//  TimerRepository.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/11/28.
//

import AlarmKit
import Dependencies
import DependenciesMacros

@DependencyClient
struct TimerRepository {
    var requestAuthorization: @Sendable () async throws -> AlarmManager.AuthorizationState
    var scheduleAlarm: @Sendable (_ interval: TimeInterval) async throws -> Alarm.ID
    var cancelAlarm: @Sendable (_ id: Alarm.ID) async throws -> Void
    var cancelAllAlarms: @Sendable () async throws -> Void
}

extension TimerRepository: DependencyKey {
    static let liveValue = TimerRepository(
        requestAuthorization: {
            try await AlarmManager.shared.requestAuthorization()
        },
        scheduleAlarm: { interval in
            let stopButton = AlarmButton(
                text: "",
                textColor: .white,
                systemImageName: "stop.fill"
            )
            let alert = AlarmPresentation.Alert(
                title: "次の手順に進んでください。",
                stopButton: stopButton
            )
            let countDown = AlarmPresentation.Countdown(
                title: ""
            )
            let presentation = AlarmPresentation(
                alert: alert,
                countdown: countDown
            )
            let attributes = AlarmAttributes<TimerMetadata>(
                presentation: presentation,
                tintColor: .orange
            )
            let countdownDuration = Alarm.CountdownDuration(
                preAlert: interval,
                postAlert: nil
            )
            let configuration = AlarmManager.AlarmConfiguration(
                countdownDuration: countdownDuration,
                attributes: attributes
            )
            let alarm = try await AlarmManager.shared.schedule(
                id: UUID(),
                configuration: configuration
            )
            return alarm.id
        },
        cancelAlarm: { id in
            try AlarmManager.shared.cancel(id: id)
        },
        cancelAllAlarms: {
            for alarm in try AlarmManager.shared.alarms {
                try? AlarmManager.shared.cancel(id: alarm.id)
            }
        }
    )
}

extension DependencyValues {
    var timerRepository: TimerRepository {
        get { self[TimerRepository.self] }
        set { self[TimerRepository.self] = newValue }
    }
}
