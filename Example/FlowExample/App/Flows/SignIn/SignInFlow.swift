//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import UIKit
import Flow

class SignInFlow: Flow<SignInFlowDiContainer, AppFlowStep, SignInFlowCompletedStep> {
    
    override init(diContainer: SignInFlowDiContainer, navigationController: UINavigationController = UINavigationController(), flowCompleted: @escaping ((SignInFlowCompletedStep) -> Void)) {
        
        super.init(diContainer: diContainer, navigationController: navigationController, flowCompleted: flowCompleted)
    }
    
    deinit {

    }
    
    override func initialView() -> UIViewController {
        
        let viewModel = SignInViewModel(
            stepPublisher: stepPublisher
        )
        let view = TemplateView(viewModel: viewModel)
        
        return view
    }
    
    override func navigate(step: AppFlowStep) {
        
        switch step {
            
        case .backTappedFromSignIn:
            completeFlow(step: .userNavigatedBackFromSignIn)
            
        case .userDidSignInFromSignIn:
            completeFlow(step: .userDidSignIn)
                                        
        default:
            break
        }
    }
}
