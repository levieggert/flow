//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import UIKit

class TemplateView: UIViewController {
    
    private let viewModel: TemplateViewModelType
         
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var continueButton: UIButton!
    
    required init(viewModel: TemplateViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: TemplateView.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("x deinit: \(type(of: self))")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view didload: \(type(of: self))")
                
        setupLayout()
        setupBinding()
        
        if let viewControllers = navigationController?.viewControllers, viewControllers.count > 1 {
            
            let item = UIBarButtonItem(
                title: "<- Go Back",
                style: .plain,
                target: self,
                action: #selector(handleBack(barButtonItem:))
            )
            
            navigationItem.leftBarButtonItem = item
        }
        
        continueButton.addTarget(self, action: #selector(handleContinue(button:)), for: .touchUpInside)
    }
    
    private func setupLayout() {
        
    }
    
    private func setupBinding() {
        
        titleLabel.text = viewModel.title
    }
    
    @objc func handleBack(barButtonItem: UIBarButtonItem) {
        viewModel.backTapped()
    }
    
    @objc func handleContinue(button: UIButton) {
        viewModel.continueTapped()
    }
}
