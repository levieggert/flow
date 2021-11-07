//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import Foundation
import Flow

class OnboardingTutorialThreeViewModel: TemplateViewModelType {
    
    private let flowStepPublisher: FlowStepPublisher<AppFlowStep>
    
    let title: String = "Tutorial Three"
    
    required init(flowStepPublisher: FlowStepPublisher<AppFlowStep>) {
        
        self.flowStepPublisher = flowStepPublisher
    }
    
    func backTapped() {
        
        flowStepPublisher.send(step: .backTappedFromOnboardingTutorialThree)
    }
    
    func continueTapped() {
        
        flowStepPublisher.send(step: .continueTappedFromOnboardingTutorialThree)
    }
}
