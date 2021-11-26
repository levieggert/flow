//
//  FlowStepSubscriber.swift
//  Flow
//
//  Created by Levi Eggert on 11/6/21.
//

import Foundation

public class FlowStepSubscriber<FlowStep: FlowStepType>: NSObject {
    
    private let stepPublishedClosure: FlowStepPublisher<FlowStep>.PublishedClosure
    
    public required init(stepPublished: @escaping FlowStepPublisher<FlowStep>.PublishedClosure) {
        
        self.stepPublishedClosure = stepPublished
    }
    
    func getStepPublishedClosure() -> FlowStepPublisher<FlowStep>.PublishedClosure {
        
        return stepPublishedClosure
    }
}
