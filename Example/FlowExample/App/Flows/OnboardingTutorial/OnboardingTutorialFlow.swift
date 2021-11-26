//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import UIKit
import Flow

class OnboardingTutorialFlow: Flow<OnboardingTutorialFlowDiContainer, AppFlowStep, OnboardingTutorialFlowCompletedStep> {
             
    override init(diContainer: OnboardingTutorialFlowDiContainer, navigationController: UINavigationController = UINavigationController(), flowCompleted: @escaping ((OnboardingTutorialFlowCompletedStep) -> Void)) {
        
        super.init(diContainer: diContainer, navigationController: navigationController, flowCompleted: flowCompleted)
    }
    
    deinit {

    }
    
    override func initialView() -> UIViewController {
        
        let viewModel = OnboardingTutorialOneViewModel(
            stepPublisher: stepPublisher
        )
        
        let view = TemplateView(viewModel: viewModel)
        
        return view
    }
    
    override func navigate(step: AppFlowStep) {
        
        switch step {
           
        case .backTappedFromOnboardingTutorialOne:
            completeFlow(step: .userNavigatedBackFromTutorial)
            
        case .continueTappedFromOnboardingTutorialOne:
            
            let viewModel = OnboardingTutorialTwoViewModel(
                stepPublisher: stepPublisher
            )
            let view = TemplateView(viewModel: viewModel)
            
            navigationController.pushViewController(view, animated: true)
            
        case .backTappedFromOnboardingTutorialTwo:
            navigationController.popViewController(animated: true)
            
        case .continueTappedFromOnboardingTutorialTwo:
            
            let viewModel = OnboardingTutorialThreeViewModel(
                stepPublisher: stepPublisher
            )
            let view = TemplateView(viewModel: viewModel)
            
            navigationController.pushViewController(view, animated: true)
            
        case .backTappedFromOnboardingTutorialThree:
            navigationController.popViewController(animated: true)
            
        case .continueTappedFromOnboardingTutorialThree:
            completeFlow(step: .userCompletedTutorial)
        
            
        default:
            break
        }
    }
}
