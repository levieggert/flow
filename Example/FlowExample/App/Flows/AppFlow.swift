//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import UIKit
import Flow

class AppFlow: Flow<CoreDiContainer, AppFlowCompletedStep> {
        
    private var onboardingFlow: OnboardingFlow?
    private var navigationStarted: Bool = false
    private var observersAdded: Bool = false
    private var appIsInBackground: Bool = false
              
    override init(diContainer: CoreDiContainer, completed: @escaping FlowCompleted) {
                      
        super.init(diContainer: diContainer, completed: completed)
        
        navigationController.view.backgroundColor = UIColor.white
        navigationController.setNavigationBarHidden(false, animated: false)
                        
        addObservers()
    }
    
    deinit {
        removeObservers()
    }
    
    override func initialView() -> UIViewController {
        return navigationController
    }
    
    override func navigate(step: FlowStepType) {
            
        guard let appStep = step as? AppFlowStep else {
            return
        }
        
        switch appStep {
            
        case .appLaunchedFromTerminatedState:
            navigateToOnboardingFlow(animated: true)
            
        case .appLaunchedFromBackgroundState:
            break
                           
        default:
            break
        }
    }
    
    private func navigateToOnboardingFlow(animated: Bool) {
        
        let onboardingFlow = OnboardingFlow(diContainer: OnboardingFlowDiContainer()) { [weak self] (step: OnboardingFlowCompletedStep) in
            
            switch step {
            
            case .completed:
                self?.dismissOnboardingFlow(animated: true)
            }
        }
                
        presentFlow(flow: onboardingFlow, animated: animated, completion: nil)
        
        self.onboardingFlow = onboardingFlow
    }
    
    private func dismissOnboardingFlow(animated: Bool) {
        
        guard let onboardingFlow = self.onboardingFlow else {
            return
        }
        
        dismissFlow(flow: onboardingFlow, animated: animated, completion: nil)
        
        self.onboardingFlow = nil
    }
}

// MARK: - Observers

extension AppFlow {
    
    private func addObservers() {
        
        guard !observersAdded else {
            return
        }
        
        observersAdded = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(notification:)), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(notification:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    private func removeObservers() {
        
        guard observersAdded else {
            return
        }
        
        observersAdded = false
        
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
}

// MARK: - Notifications

extension AppFlow {
    
    @objc func handleNotification(notification: Notification) {
        
        if notification.name == UIApplication.didBecomeActiveNotification {
            
            let appLaunchedFromTerminatedState: Bool = !navigationStarted
            let appLaunchedFromBackgroundState: Bool = navigationStarted && appIsInBackground
            
            if appLaunchedFromTerminatedState {
                navigationStarted = true
                navigate(step: AppFlowStep.appLaunchedFromTerminatedState)
            }
            else if appLaunchedFromBackgroundState {
                appIsInBackground = false
                navigate(step: AppFlowStep.appLaunchedFromBackgroundState)
            }
        }
        else if notification.name == UIApplication.didEnterBackgroundNotification {
            appIsInBackground = true
        }
    }
}
