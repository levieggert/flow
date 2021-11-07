//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import Foundation
import Flow

class TemplateViewModel: TemplateViewModelType {
    
    private let flowStepPublisher: FlowStepPublisher<AppFlowStep>
    
    let title: String = "Template"
    
    required init(flowStepPublisher: FlowStepPublisher<AppFlowStep>) {
        
        self.flowStepPublisher = flowStepPublisher
    }
    
    func backTapped() {
        
    }
    
    func continueTapped() {
        
    }
}
