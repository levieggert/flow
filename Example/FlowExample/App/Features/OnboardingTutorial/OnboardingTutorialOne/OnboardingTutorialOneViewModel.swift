//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import Foundation
import Flow

class OnboardingTutorialOneViewModel: TemplateViewModelType {
    
    private let stepPublisher: FlowStepPublisher<AppFlowStep>
    
    let title: String = "Tutorial One"
    
    required init(stepPublisher: FlowStepPublisher<AppFlowStep>) {
        
        self.stepPublisher = stepPublisher
    }
    
    func backTapped() {
        stepPublisher.send(step: .backTappedFromOnboardingTutorialOne)
    }
    
    func continueTapped() {
        stepPublisher.send(step: .continueTappedFromOnboardingTutorialOne)
    }
}
