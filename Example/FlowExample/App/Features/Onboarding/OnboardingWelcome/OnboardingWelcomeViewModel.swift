//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import Foundation
import Flow

class OnboardingWelcomeViewModel: TemplateViewModelType {
    
    private let flowStepPublisher: FlowStepPublisher<AppFlowStep>
    
    let title: String = "Welcome"
    
    required init(flowStepPublisher: FlowStepPublisher<AppFlowStep>) {
        
        self.flowStepPublisher = flowStepPublisher
    }
    
    func backTapped() {
        
    }
    
    func continueTapped() {
        flowStepPublisher.send(step: .continueTappedFromWelcome)
    }
}
