//
//  InstructionProgress.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import SwiftUI

struct InstructionProgress: View {
    private let totalSteps: Int
    private let currentStep: Int

    init(totalSteps: Int, currentStep: Int) {
        self.totalSteps = totalSteps
        self.currentStep = currentStep
    }

    private var progressValue: Double {
        guard totalSteps > 0 else { return 0 }
        return min(max(Double(currentStep) / Double(totalSteps), 0), 1)
    }
    
    var body: some View {
        HStack {
            ProgressView(value: progressValue)
                .frame(height: 8)
                .cornerRadius(4)
                .tint(Color.secondary)

            Text("\(currentStep) / \(totalSteps)")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .fixedSize()
        }
    }
}

#Preview {
    InstructionProgress(totalSteps: 5, currentStep: 1)
    InstructionProgress(totalSteps: 5, currentStep: 3)
    InstructionProgress(totalSteps: 5, currentStep: 5)
    InstructionProgress(totalSteps: 0, currentStep: 0)
}
