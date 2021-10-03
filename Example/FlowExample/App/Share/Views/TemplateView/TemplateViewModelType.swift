//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import Foundation

protocol TemplateViewModelType {
    
    var title: String { get }
    
    func backTapped()
    func continueTapped()
}
