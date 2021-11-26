//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import Foundation
import Flow

class TemplateViewModel<FlowStep: FlowStepType>: TemplateViewModelType {
        
    private let stepPublisher: FlowStepPublisher<FlowStep>
    
    let title: String = "Template"
    
    required init(stepPublisher: FlowStepPublisher<FlowStep>) {
        
        self.stepPublisher = stepPublisher
    }
    
    func backTapped() {
        
    }
    
    func continueTapped() {
        
    }
}
