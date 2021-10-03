//
//  SignInFlowCompletedStep.swift
//  SwiftFlow-iOS
//
//  Created by Levi Eggert on 9/5/21.
//

import Foundation
import Flow

enum SignInFlowCompletedStep: FlowCompletedStepType {
    
    case userNavigatedBackFromSignIn
    case userDidSignIn
}
