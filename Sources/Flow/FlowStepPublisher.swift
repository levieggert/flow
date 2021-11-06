//
//  FlowStepPublisher.swift
//  Flow
//
//  Created by Levi Eggert on 11/6/21.
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
        
        subscribers.append(subscriber)
        
        return subscriber
    }
    
    public func send(step: FlowStep) {
        
        for subscriber in subscribers {
            
            subscriber.getStepPublishedClosure()(step)
        }
    }
}
