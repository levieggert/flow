//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import UIKit
import Flow

class SignInFlow: Flow<SignInFlowDiContainer, SignInFlowCompletedStep> {
    
    override init(diContainer: SignInFlowDiContainer, completed: @escaping FlowCompleted) {
        
        super.init(diContainer: diContainer, completed: completed)
    }
    
    deinit {

    }
    
    override func initialView() -> UIViewController {
        
        let viewModel = SignInViewModel(flowDelegate: self)
        let view = TemplateView(viewModel: viewModel)
        
        return view
    }
    
    override func navigate(step: FlowStepType) {
             
        guard let appStep = step as? AppFlowStep else {
            return
        }
        
        switch appStep {
            
        case .backTappedFromSignIn:
            completeFlow(step: .userNavigatedBackFromSignIn)
            
        case .userDidSignInFromSignIn:
            completeFlow(step: .userDidSignIn)
                                        
        default:
            break
        }
    }
}
