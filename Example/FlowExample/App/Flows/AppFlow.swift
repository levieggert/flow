//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import UIKit
import Flow

class AppFlow: Flow<CoreDiContainer, AppFlowStep, AppFlowCompletedStep> {
        
    private var onboardingFlow: OnboardingFlow?
    private var navigationStarted: Bool = false
    private var observersAdded: Bool = false
    private var appIsInBackground: Bool = false
    
    override init(diContainer: CoreDiContainer, navigationController: UINavigationController = UINavigationController(), flowCompleted: @escaping ((AppFlowCompletedStep) -> Void)) {
        
        super.init(diContainer: diContainer, navigationController: navigationController, flowCompleted: flowCompleted)
        
        navigationController.view.backgroundColor = UIColor.white
        navigationController.setNavigationBarHidden(false, animated: false)
                        
        addObservers()
    }

    deinit {
        removeObservers()
    }
    
    override func initialView() -> FlowView {
        return FlowView(view: navigationController)
    }
    
    override func navigate(step: AppFlowStep) {
        
        switch step {
            
        case .appLaunchedFromTerminatedState:
            navigateToOnboardingFlow(animated: true)
            
        case .appLaunchedFromBackgroundState:
            break
                           
        default:
            break
        }
    }
    
    private func navigateToOnboardingFlow(animated: Bool) {
        
        let onboardingFlow = OnboardingFlow(diContainer: OnboardingFlowDiContainer()) { [weak self] (completedStep: OnboardingFlowCompletedStep) in
            
            switch completedStep {
            case .completed:
                self?.dismissOnboardingFlow(animated: true)
            }
        }
        
        presentFlow(flow: onboardingFlow, animated: true, presentationCompleted: nil)
        
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
