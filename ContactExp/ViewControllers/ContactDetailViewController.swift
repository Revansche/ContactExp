//
//  ContactDetailViewController.swift
//  ContactExp
//
//  Created by Ghean Ginanjar on 22/03/19.
//  Copyright © 2019 Ghean Ginanjar. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
  
    var viewModel: ContactDetailViewModel
  
    init(viewModel: ContactDetailViewModel) {
      self.viewModel = viewModel
      super.init(nibName: nil, bundle: nil)
    }
  
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
