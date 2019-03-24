//
//  MutateContactViewController.swift
//  ContactExp
//
//  Created by Ghean Ginanjar on 22/03/19.
//  Copyright © 2019 Ghean Ginanjar. All rights reserved.
//

import UIKit
import JGProgressHUD

class MutateContactViewController: UIViewController {

  @IBOutlet weak var gradientLayer: UIView!
  @IBOutlet weak var firstNameField: UITextField!
  @IBOutlet weak var lastNameField: UITextField!
  @IBOutlet weak var mobileNumberFIeld: UITextField!
  @IBOutlet weak var emailField: UITextField!
  @IBOutlet weak var userImageView: UIImageView!
  
  private var viewModel: MutateContactViewModel
  var hud: JGProgressHUD!
  
  init(viewModel: MutateContactViewModel){
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    hud = JGProgressHUD(style: .dark)
    UtilFunctions.gradientLayerSetup(on: gradientLayer)
    UtilFunctions.roundClipping(on: userImageView)
    
    setupDetailInfo()
    setupNavigationBar()
    viewModel.setNetworkViewDelegate(object: self)
    view.accessibilityIdentifier = "contactMutateView"
  }
  
  private func setupDetailInfo() {
    firstNameField.text = viewModel.contactFirstName
    lastNameField.text = viewModel.contactLastName
    mobileNumberFIeld.text = viewModel.contactPhoneNumber
    emailField.text = viewModel.contactEmail
    userImageView.image(from: viewModel.contactImageLink)
    
    firstNameField.delegate = self
    firstNameField.accessibilityIdentifier = "firstNameField"
    lastNameField.delegate = self
    mobileNumberFIeld.delegate = self
    emailField.delegate = self
  }
  
  private func setupNavigationBar() {
    let rightButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(navigationRightBarAction))
    let leftButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(navigationLeftBarAction))
    self.navigationItem.rightBarButtonItem = rightButtonItem
    self.navigationItem.leftBarButtonItem = leftButtonItem
  }
  
  @objc private func navigationRightBarAction() {
    view.endEditing(true)
    viewModel.proceedAction()
  }
  
  @objc private func navigationLeftBarAction() {
    navigationController?.popViewController(animated: true)
  }
}

// THIS IS A COMPROMISE.. should have binding going on but im out of time
extension MutateContactViewController: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    guard let textValue = textField.text else {
      return
    }
    if textField === firstNameField {
      viewModel.contactFirstName = textValue
    } else if textField === lastNameField {
      viewModel.contactLastName = textValue
    } else if textField === mobileNumberFIeld {
      viewModel.contactPhoneNumber = textValue
    } else if textField === emailField {
      viewModel.contactEmail = textValue
    }
  }
}

extension MutateContactViewController: NetworkViewProtocol {
  func showLoader() {
    hud.textLabel.text = "Sending Data.."
    hud.show(in: self.view)
  }
  
  func hideLoader() {
    hud.dismiss(afterDelay: 1.0)
  }
  
  func showResult() {
    hud.textLabel.text = "Finish!!"
    hideLoader()
  }
}
