//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import Foundation
import Flow

class OnboardingWelcomeViewModel: TemplateViewModelType {
    
    private let stepPublisher: FlowStepPublisher<AppFlowStep>
    
    let title: String = "Welcome"
    
    required init(stepPublisher: FlowStepPublisher<AppFlowStep>) {
        
        self.stepPublisher = stepPublisher
    }
    
    func backTapped() {
        
    }
    
    func continueTapped() {
        stepPublisher.send(step: .continueTappedFromWelcome)
    }
}
