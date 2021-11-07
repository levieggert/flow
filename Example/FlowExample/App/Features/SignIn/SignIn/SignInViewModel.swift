//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import Foundation
import Flow

class SignInViewModel: TemplateViewModelType {
    
    private let flowStepPublisher: FlowStepPublisher<AppFlowStep>
    
    let title: String = "Sign In"
    
    required init(flowStepPublisher: FlowStepPublisher<AppFlowStep>) {
        
        self.flowStepPublisher = flowStepPublisher
    }
    
    func backTapped() {
        
        flowStepPublisher.send(step: .backTappedFromSignIn)
    }
    
    func continueTapped() {
        
        flowStepPublisher.send(step: .userDidSignInFromSignIn)
    }
}
