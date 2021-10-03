//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import Foundation
import Flow

class OnboardingTutorialThreeViewModel: TemplateViewModelType {
    
    private weak var flowDelegate: FlowDelegate?
    
    let title: String = "Tutorial Three"
    
    required init(flowDelegate: FlowDelegate) {
        
        self.flowDelegate = flowDelegate
    }
    
    func backTapped() {
        flowDelegate?.navigate(step: AppFlowStep.backTappedFromOnboardingTutorialThree)
    }
    
    func continueTapped() {
        flowDelegate?.navigate(step: AppFlowStep.continueTappedFromOnboardingTutorialThree)
    }
}
