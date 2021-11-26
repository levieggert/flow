//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import UIKit

open class Flow<FlowDiContainer: FlowDiContainerType, FlowStep: FlowStepType, FlowCompletedStep: FlowCompletedStepType>: NSObject {
        
    private let flowCompletedClosure: ((_ step: FlowCompletedStep) -> Void)?
    private var stepSubscriber: FlowStepSubscriber<FlowStep>?
    
    public private(set) var navigationController: UINavigationController
    public let diContainer: FlowDiContainer
    public let stepPublisher: FlowStepPublisher<FlowStep> = FlowStepPublisher()
    
    public init(diContainer: FlowDiContainer, navigationController: UINavigationController = UINavigationController(), flowCompleted: @escaping ((_ step: FlowCompletedStep) -> Void)) {
        
        print("init flow: \(type(of: self))")
        
        self.diContainer = diContainer
        self.navigationController = navigationController
        self.flowCompletedClosure = flowCompleted
        
        super.init()
        
        addStepSubscriber()
    }
    
    private func addStepSubscriber() {
        
        guard stepSubscriber == nil else {
            return
        }
        
        let stepSubscriber: FlowStepSubscriber<FlowStep> = FlowStepSubscriber(stepPublished: { [weak self] (step: FlowStep) in
            self?.navigate(step: step)
        })
        
        stepPublisher.subscribe(subscriber: stepSubscriber)
        
        self.stepSubscriber = stepSubscriber
    }
    
    deinit {
        print("x deinit: \(type(of: self))")
        
        if let stepSubscriber = stepSubscriber {
            stepPublisher.unsubscribe(subscriber: stepSubscriber)
        }
    }
    
    open var presentsInitialViewOnFlowInsteadOfNavigationController: Bool {
        return false
    }
    
    open func initialView() -> FlowView {
        assertionFailure("\nFlow: initialView() Subclasses should override this method.")
        return FlowView(view: UIViewController())
    }
    
    open func navigate(step: FlowStep) {
        assertionFailure("\nFlow: navigate(step: FlowStep) Subclasses should override this method.")
    }
    
    // MARK: _
    
    public func completeFlow(step: FlowCompletedStep) {
        flowCompletedClosure?(step)
    }
    
    // MARK: -
    
    public func addFlow<T: FlowDiContainerType, U: FlowStepType, V: FlowCompletedStepType>(flow: Flow<T, U, V>, sharesNavigationControllerWithParentFlow: Bool) {
                
        if sharesNavigationControllerWithParentFlow {
            flow.navigationController = navigationController
        }
    }
        
    public func setFlow<T: FlowDiContainerType, U: FlowStepType, V: FlowCompletedStepType>(flow: Flow<T, U, V>, animated: Bool) {
        
        let initialFlowView: FlowView = flow.initialView()
        let initialView: UIViewController = initialFlowView.view
        
        if initialView is UINavigationController {
            assertionFailure("\nFlow: setFlow() Failed to set flow because the initialView() is a UINavigationController.  initialView() must be a UIViewController.")
        }
        
        addFlow(
            flow: flow,
            sharesNavigationControllerWithParentFlow: true
        )
                
        navigationController.setViewControllers([initialView], animated: animated)
    }
    
    public func pushFlow<T: FlowDiContainerType, U: FlowStepType, V: FlowCompletedStepType>(flow: Flow<T, U, V>, animated: Bool) {
        
        let initialFlowView: FlowView = flow.initialView()
        let initialView: UIViewController = initialFlowView.view
        
        if initialView is UINavigationController {
            assertionFailure("\nFlow: pushFlow() Failed to push flow because the initialView() is a UINavigationController.  initialView() must be a UIViewController.")
        }
            
        addFlow(
            flow: flow,
            sharesNavigationControllerWithParentFlow: true
        )
        
        if navigationController.viewControllers.isEmpty {
            navigationController.setViewControllers([initialView], animated: animated)
        }
        else {
            navigationController.pushViewController(initialView, animated: animated)
        }
    }
    
    public func presentFlow<T: FlowDiContainerType, U: FlowStepType, V: FlowCompletedStepType>(flow: Flow<T, U, V>, animated: Bool, presentationCompleted: (() -> Void)?) {
        
        let initialFlowView: FlowView = flow.initialView()
        let initialView: UIViewController = initialFlowView.view
        
        if initialView is UINavigationController {
            assertionFailure("\nFlow: presentFlow() Failed to present flow because the initialView() is a UINavigationController.  initialView() must be a UIViewController.\n  parentFlow: \(type(of: self))\n  childFlow: \(type(of: flow))")
        }
        
        let viewForPresentation: UIViewController
        
        if !flow.presentsInitialViewOnFlowInsteadOfNavigationController {
            
            addFlow(
                flow: flow,
                sharesNavigationControllerWithParentFlow: false
            )
            
            flow.navigationController.setViewControllers([initialView], animated: false)
            
            viewForPresentation = flow.navigationController
        }
        else {
            
            addFlow(
                flow: flow,
                sharesNavigationControllerWithParentFlow: true
            )
            
            viewForPresentation = initialView
        }
        
        if animated {
            navigationController.present(viewForPresentation, animated: true, completion: presentationCompleted)
        }
        else {
            navigationController.present(viewForPresentation, animated: false, completion: nil)
            presentationCompleted?()
        }
    }
    
    public func dismissFlow<T: FlowDiContainerType, U: FlowStepType, V: FlowCompletedStepType>(flow: Flow<T, U, V>, animated: Bool, completion: (() -> Void)?) {
        
        guard navigationController.presentedViewController == flow.navigationController else {
            assertionFailure("\nFlow: dismissFlow() Failed to dismiss flow because the flow wasn't presented by this flow.")
            return
        }
        
        if animated {
            navigationController.dismiss(animated: true, completion: completion)
        }
        else {
            navigationController.dismiss(animated: false, completion: completion)
            completion?()
        }
    }
}

