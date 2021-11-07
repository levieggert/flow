//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import UIKit
import Flow

class OnboardingFlow: Flow<OnboardingFlowDiContainer, AppFlowStep, OnboardingFlowCompletedStep> {
    
    private var tutorialFlow: OnboardingTutorialFlow?
    private var signInFlow: SignInFlow?
        
    override init(diContainer: OnboardingFlowDiContainer, completed: @escaping FlowCompleted) {
                
        super.init(diContainer: diContainer, completed: completed)
        
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.view.backgroundColor = UIColor.white
        navigationController.setNavigationBarHidden(false, animated: false)
    }
    
    deinit {
        self.tutorialFlow = nil
        self.signInFlow = nil
    }
    
    override func initialView() -> UIViewController {
        
        let viewModel = OnboardingWelcomeViewModel(
            flowStepPublisher: stepPublisher
        )
        let view = TemplateView(viewModel: viewModel)
        
        return view
    }
    
    override func navigate(step: AppFlowStep) {
        
        switch step {
       
        case .continueTappedFromWelcome:
            navigateToTutorialFlow(animated: true)
                                    
        default:
            break
        }
    }
    
    private func navigateToTutorialFlow(animated: Bool) {
        
        let tutorialFlow = OnboardingTutorialFlow(diContainer: OnboardingTutorialFlowDiContainer()) { [weak self] (completedStep: OnboardingTutorialFlowCompletedStep) in
            
            switch completedStep {
            
            case .userNavigatedBackFromTutorial:
                self?.dismissTutorialFlow(animated: true)
                
            case .userCompletedTutorial:
                self?.navigateToSignInFlow(animated: true)
            }
        }
        
        pushFlow(flow: tutorialFlow, animated: true)
        
        self.tutorialFlow = tutorialFlow
    }
    
    private func dismissTutorialFlow(animated: Bool) {
        
        guard tutorialFlow != nil else {
            return
        }
        
        navigationController.popViewController(animated: animated)
        tutorialFlow = nil
    }
    
    private func navigateToSignInFlow(animated: Bool) {
        
        let signInFlow = SignInFlow(diContainer: SignInFlowDiContainer()) { [weak self] (completedStep: SignInFlowCompletedStep) in
            
            switch completedStep {
            
            case .userNavigatedBackFromSignIn:
                self?.dismissSignInFlow(animated: true)
        
            case .userDidSignIn:
                self?.completeFlow(step: .completed)
            }
        }
        
        pushFlow(flow: signInFlow, animated: true)
                
        self.signInFlow = signInFlow
    }
    
    private func dismissSignInFlow(animated: Bool) {
        
        guard signInFlow != nil else {
            return
        }
        
        navigationController.popViewController(animated: true)
        signInFlow = nil
    }
}
