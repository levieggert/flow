//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import Foundation
import Flow

class OnboardingTutorialOneViewModel: TemplateViewModelType {
    
    private let flowStepPublisher: FlowStepPublisher<AppFlowStep>
    
    let title: String = "Tutorial One"
    
    required init(flowStepPublisher: FlowStepPublisher<AppFlowStep>) {
        
        self.flowStepPublisher = flowStepPublisher
    }
    
    func backTapped() {
        
        flowStepPublisher.send(step: .backTappedFromOnboardingTutorialOne)
    }
    
    func continueTapped() {
        
        flowStepPublisher.send(step: .continueTappedFromOnboardingTutorialOne)
    }
}
