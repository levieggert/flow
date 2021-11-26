//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import Foundation
import Flow

class OnboardingTutorialThreeViewModel: TemplateViewModelType {
    
    private let stepPublisher: FlowStepPublisher<AppFlowStep>
    
    let title: String = "Tutorial Three"
    
    required init(stepPublisher: FlowStepPublisher<AppFlowStep>) {
        
        self.stepPublisher = stepPublisher
    }
    
    func backTapped() {
        stepPublisher.send(step: .backTappedFromOnboardingTutorialThree)
    }
    
    func continueTapped() {
        stepPublisher.send(step: .continueTappedFromOnboardingTutorialThree)
    }
}
