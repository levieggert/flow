//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import Foundation
import Flow

class OnboardingTutorialTwoViewModel: TemplateViewModelType {
    
    private let stepPublisher: FlowStepPublisher<AppFlowStep>
    
    let title: String = "Tutorial Two"
    
    required init(stepPublisher: FlowStepPublisher<AppFlowStep>) {
        
        self.stepPublisher = stepPublisher
    }
    
    func backTapped() {
        stepPublisher.send(step: .backTappedFromOnboardingTutorialTwo)
    }
    
    func continueTapped() {
        stepPublisher.send(step: .continueTappedFromOnboardingTutorialTwo)
    }
}
