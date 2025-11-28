//
//  CookingTimer.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/11/28.
//

import AlarmKit

struct CookingTimer: Equatable, Identifiable {
    let alarmID: Alarm.ID
    let instructionID: Instruction.ID
    let duration: Range<Date>

    var id: Alarm.ID { alarmID }

    var isExpired: Bool {
        Date() > duration.upperBound
    }
}
