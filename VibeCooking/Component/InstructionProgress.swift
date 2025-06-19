//
//  VibeCooking
//
//

import SwiftUI

struct InstructionProgress: View {
    let totalSteps: Int
    let currentStep: Int
    
    private var progressValue: Double {
        guard totalSteps > 0 else { return 0 }
        return min(max(Double(currentStep) / Double(totalSteps), 0), 1)
    }
    
    var body: some View {
        HStack(spacing: 8) {
            ProgressView(value: progressValue)
                .progressViewStyle(LinearProgressViewStyle(tint: Color(red: 0.28, green: 0.31, blue: 0.36)))
                .frame(height: 8)
                .background(Color(red: 0.9, green: 0.9, blue: 0.9))
                .cornerRadius(4)
            
            Text("\(currentStep) / \(totalSteps)")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
                .fixedSize()
        }
    }
}

struct InstructionProgress_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            InstructionProgress(totalSteps: 5, currentStep: 1)
            InstructionProgress(totalSteps: 5, currentStep: 3)
            InstructionProgress(totalSteps: 5, currentStep: 5)
            InstructionProgress(totalSteps: 0, currentStep: 0)
        }
        .padding()
    }
}
