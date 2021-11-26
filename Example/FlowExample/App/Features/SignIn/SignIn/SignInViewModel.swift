//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import Foundation
import Flow

class SignInViewModel: TemplateViewModelType {
    
    private let stepPublisher: FlowStepPublisher<AppFlowStep>
    
    let title: String = "Sign In"
    
    required init(stepPublisher: FlowStepPublisher<AppFlowStep>) {
        
        self.stepPublisher = stepPublisher
    }
    
    func backTapped() {
        stepPublisher.send(step: .backTappedFromSignIn)
    }
    
    func continueTapped() {
        stepPublisher.send(step: .userDidSignInFromSignIn)
    }
}
