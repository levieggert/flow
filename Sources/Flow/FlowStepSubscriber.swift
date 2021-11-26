//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
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
