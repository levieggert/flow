//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import UIKit

open class Flow<FlowDiContainer: FlowDiContainerType, FlowCompletedStep: FlowCompletedStepType>: NSObject, FlowDelegate {
    
    public typealias FlowCompleted = ((_ step: FlowCompletedStep) -> Void)
    
    public private(set) var navigationController: UINavigationController = UINavigationController()
    let diContainer: FlowDiContainer
    
    private let flowCompletedClosure: FlowCompleted?
    
    public init(diContainer: FlowDiContainer, completed: @escaping FlowCompleted) {
        print("init flow: \(type(of: self))")
        self.diContainer = diContainer
        self.flowCompletedClosure = completed
        super.init()
    }
    
    public init(navigationController: UINavigationController, diContainer: FlowDiContainer, completed: @escaping FlowCompleted) {
        print("init flow: \(type(of: self))")
        self.navigationController = navigationController
        self.diContainer = diContainer
        self.flowCompletedClosure = completed
        super.init()
    }
    
    deinit {
        print("x deinit: \(type(of: self))")
    }
    
    open var presentsInitialViewOnFlowInsteadOfNavigationController: Bool {
        return false
    }
    
    open func initialView() -> UIViewController {
        assertionFailure("\nFlow: initialView() Subclasses should override this method.")
        return UIViewController()
    }
    
    open func navigate(step: FlowStepType) {
        assertionFailure("\nFlow: navigate(step: FlowStepType) Subclasses should override this method.")
    }
    
    // MARK: _
    
    public func completeFlow(step: FlowCompletedStep) {
        flowCompletedClosure?(step)
    }
    
    // MARK: -
    
    public func addFlow<T: FlowDiContainerType, U: FlowCompletedStepType>(flow: Flow<T, U>, sharesNavigationControllerWithParentFlow: Bool) {
        
        if sharesNavigationControllerWithParentFlow {
            flow.navigationController = navigationController
        }
    }
        
    public func setFlow<T: FlowDiContainerType, U: FlowCompletedStepType>(flow: Flow<T, U>, animated: Bool) {
        
        let initialView: UIViewController = flow.initialView()
        
        if initialView is UINavigationController {
            assertionFailure("\nFlow: setFlow() Failed to set flow because the initialView() is a UINavigationController.  initialView() must be a UIViewController.")
        }
        
        addFlow(
            flow: flow,
            sharesNavigationControllerWithParentFlow: true
        )
                
        navigationController.setViewControllers([initialView], animated: animated)
    }
    
    public func pushFlow<T: FlowDiContainerType, U: FlowCompletedStepType>(flow: Flow<T, U>, animated: Bool) {
        
        let initialView: UIViewController = flow.initialView()
        
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
    
    public func presentFlow<T: FlowDiContainerType, U: FlowCompletedStepType>(flow: Flow<T, U>, animated: Bool, completion: (() -> Void)?) {
        
        let initialView: UIViewController = flow.initialView()
        
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
            navigationController.present(viewForPresentation, animated: true, completion: completion)
        }
        else {
            navigationController.present(viewForPresentation, animated: false, completion: nil)
            completion?()
        }
    }
    
    public func dismissFlow<T: FlowDiContainerType, U: FlowCompletedStepType>(flow: Flow<T, U>, animated: Bool, completion: (() -> Void)?) {
        
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

