//
//  ContactDetailViewController.swift
//  ContactExp
//
//  Created by Ghean Ginanjar on 22/03/19.
//  Copyright © 2019 Ghean Ginanjar. All rights reserved.
//

import UIKit
import JGProgressHUD

class ContactDetailViewController: UIViewController {
  
  @IBOutlet weak var gradientLayer: UIView!
  @IBOutlet weak var userImageView: UIImageView!
  @IBOutlet weak var userFullNameLabel: UILabel!
  //This Could be moved to a custom Class, but thinking about the deadline... i compromised...
  @IBOutlet weak var favoriteContainer: UIView!
  @IBOutlet weak var favoriteIcon: UIImageView!
  @IBOutlet weak var mobileTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  
  var viewModel: ContactDetailViewModel
  var hud: JGProgressHUD!
  
    init(viewModel: ContactDetailViewModel) {
      self.viewModel = viewModel
      super.init(nibName: nil, bundle: nil)
    }
  
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        hud = JGProgressHUD(style: .dark)
        setRoundClippingUserImage()
        viewModel.setNetworkViewDelegate(object: self)
        setupNavigationBar()
      
        view.accessibilityIdentifier = "contactDetailView"
    }
  
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      viewModel.viewWillAppear()
    }
  
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      print(gradientLayer.frame.size.height)
      UtilFunctions.gradientLayerSetup(on: gradientLayer)
    }
  
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
    }
  
    private func setupNavigationBar() {
      let rightButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(navigationRightBarAction))
      self.navigationItem.rightBarButtonItem = rightButtonItem
    }
  
    @objc private func navigationRightBarAction() {      
      let action = MutateContactAddAction()
      ListRouter.goToMutateContact(on: self.navigationController, for: action, with: viewModel.getContactObject())
    }
  
    private func setRoundClippingUserImage() {
      UtilFunctions.roundClipping(on: userImageView)
    }
}

extension ContactDetailViewController: NetworkViewProtocol {
  func showLoader() {
    hud.textLabel.text = "Loeading"
    hud.show(in: self.view)
  }
  
  func hideLoader() {
    hud.dismiss(afterDelay: 1.0)
  }
  
  func showResult() {
    hideLoader()
    userImageView.image(from: viewModel.contactImage)
    userFullNameLabel.text = viewModel.contactFullName
    if viewModel.contactIsFavorite {
      favoriteIcon.image = UIImage(named: "Icon_Favorite_Filled")
    }
    mobileTextField.text = viewModel.contactPhoneNumber
    emailTextField.text = viewModel.contactEmail
  }
}
