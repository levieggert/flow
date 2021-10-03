//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import Foundation
import Flow

class OnboardingWelcomeViewModel: TemplateViewModelType {
    
    private weak var flowDelegate: FlowDelegate?
    
    let title: String = "Welcome"
    
    required init(flowDelegate: FlowDelegate) {
        
        self.flowDelegate = flowDelegate
    }
    
    func backTapped() {
        
    }
    
    func continueTapped() {
        flowDelegate?.navigate(step: AppFlowStep.continueTappedFromWelcome)
    }
}
