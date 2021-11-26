//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import Foundation

public class FlowStepPublisher<FlowStep: FlowStepType> {
    
    public typealias PublishedClosure = ((_ step: FlowStep) -> Void)
    
    private var subscribers: [FlowStepSubscriber<FlowStep>] = Array()
    
    public required init() {
        
    }
    
    deinit {
        
    }
    
    public func unsubscribe(subscriber: FlowStepSubscriber<FlowStep>) {
        
        guard let index = subscribers.firstIndex(of: subscriber) else {
            return
        }
        
        subscribers.remove(at: index)
    }
    
    public func subscribe(stepPublished: @escaping FlowStepPublisher<FlowStep>.PublishedClosure) -> FlowStepSubscriber<FlowStep> {
        
        let subscriber: FlowStepSubscriber = FlowStepSubscriber(stepPublished: stepPublished)
            
        subscribe(subscriber: subscriber)
        
        return subscriber
    }
    
    public func subscribe(subscriber: FlowStepSubscriber<FlowStep>) {
                
        guard !subscribers.contains(subscriber) else {
            return
        }
        
        subscribers.append(subscriber)
    }
    
    public func send(step: FlowStep) {
        
        for subscriber in subscribers {
            
            subscriber.getStepPublishedClosure()(step)
        }
    }
}
