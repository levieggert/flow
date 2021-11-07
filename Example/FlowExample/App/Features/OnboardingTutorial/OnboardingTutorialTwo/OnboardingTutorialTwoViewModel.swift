//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import Foundation
import Flow

class OnboardingTutorialTwoViewModel: TemplateViewModelType {
    
    private let flowStepPublisher: FlowStepPublisher<AppFlowStep>
    
    let title: String = "Tutorial Two"
    
    required init(flowStepPublisher: FlowStepPublisher<AppFlowStep>) {
        
        self.flowStepPublisher = flowStepPublisher
    }
    
    func backTapped() {
        flowStepPublisher.send(step: .backTappedFromOnboardingTutorialTwo )
    }
    
    func continueTapped() {
        flowStepPublisher.send(step: .continueTappedFromOnboardingTutorialTwo )
    }
}
