//
//  ContactListViewController.swift
//  ContactExp
//
//  Created by Ghean Ginanjar on 22/03/19.
//  Copyright © 2019 Ghean Ginanjar. All rights reserved.
//

import UIKit
import JGProgressHUD

class ContactListViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  private var contactListViewModel: ContactListViewModel!
  var hud: JGProgressHUD!
  
  override func viewDidLoad() {
      super.viewDidLoad()
      hud = JGProgressHUD(style: .dark)
      contactListViewModel = ContactListViewModel(networkViewDelegate: self)
      contactListViewModel.getContactList()
      
      setNavigationBar("Contacts")
      registerCell()
      tableView.delegate = self
      tableView.dataSource = self
    
      view.accessibilityIdentifier = "contactListView"
      tableView.accessibilityIdentifier = "contactListTable"
  }
  
  func setNavigationBar(_ title: String) {
    let rightButtonItem = UIBarButtonItem(barButtonSystemItem: .add
      , target: self, action: #selector(navigationRightBarAction))
    rightButtonItem.accessibilityIdentifier = "navbarRightItem"
    let leftButtonItem = UIBarButtonItem(title: "Groups", style: .plain, target: nil, action: nil)
    
    self.navigationItem.title = title
    self.navigationItem.rightBarButtonItem = rightButtonItem
    self.navigationItem.leftBarButtonItem = leftButtonItem
  }
  
  private func registerCell() {
    let cellClassName = "ContactTableViewCell"
    self.tableView.register(UINib(nibName: cellClassName, bundle: nil),
                            forCellReuseIdentifier: cellClassName)
  }
  
  @objc private func navigationRightBarAction() {
    ListRouter.goToAddContact(on: self.navigationController)
  }
}

extension ContactListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contactListViewModel.groupedContacts[section].count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as? ContactTableViewCell {
      let contactItem = contactListViewModel.groupedContacts[indexPath.section][indexPath.row]
      cell.update(withContact: contactItem)
      return cell
    } else {
      return UITableViewCell()
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return contactListViewModel.groupedContacts.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 64
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if contactListViewModel.sectionIndexTitleLetter.count == 0 {
      return nil
    }
    return contactListViewModel.sectionIndexTitleLetter[section]
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let contactItem = contactListViewModel.groupedContacts[indexPath.section][indexPath.row]
    ListRouter.goToDetail(withData: contactItem, onNavigationController: self.navigationController)
  }
  
  func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    return contactListViewModel.sectionIndexTitleLetter
  }
}

extension ContactListViewController: NetworkViewProtocol {
  func showLoader() {
    hud.textLabel.text = "Loeading.."
    hud.show(in: self.view)
  }
  
  func hideLoader() {
    hud.dismiss(afterDelay: 1.0)
  }
  
  func showResult() {
    hideLoader()
    tableView.reloadData()
  }
}

struct ListRouter {
  
  static func goToAddContact(on navigationController: UINavigationController?) {
    let action = MutateContactAddAction()
    let contactModel = ContactsModel()
    let viewModel = MutateContactViewModel(action: action, contactModel: contactModel)
    let viewController = MutateContactViewController(viewModel: viewModel)
    navigationController?.pushViewController(viewController, animated: true)
  }
  
  static func goToMutateContact(on navigationController: UINavigationController?, for action: Action, with contactModel: ContactsModel = ContactsModel()) {
    let viewModel = MutateContactViewModel(action: action, contactModel: contactModel)
    let viewController = MutateContactViewController(viewModel: viewModel)
    navigationController?.pushViewController(viewController, animated: true)
  }
  
  static func goToDetail(withData contactData: ContactItemListModel, onNavigationController navigationController: UINavigationController?) {
    let viewModel = ContactDetailViewModel(detailUrl: contactData.url)
    let viewController = ContactDetailViewController(viewModel: viewModel)
    navigationController?.pushViewController(viewController, animated: true)
  }
}
