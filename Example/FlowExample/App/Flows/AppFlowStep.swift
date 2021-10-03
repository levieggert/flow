//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import Foundation
import Flow

enum AppFlowStep: FlowStepType {
    
    // app
    case appLaunchedFromTerminatedState
    case appLaunchedFromBackgroundState
    
    // onboarding
    case continueTappedFromWelcome
    
    // onboarding tutorial
    case backTappedFromOnboardingTutorialOne
    case continueTappedFromOnboardingTutorialOne
    case backTappedFromOnboardingTutorialTwo
    case continueTappedFromOnboardingTutorialTwo
    case backTappedFromOnboardingTutorialThree
    case continueTappedFromOnboardingTutorialThree
    
    // sign in
    case backTappedFromSignIn
    case userDidSignInFromSignIn
}
