//
//  ContactListViewController.swift
//  ContactExp
//
//  Created by Ghean Ginanjar on 22/03/19.
//  Copyright © 2019 Ghean Ginanjar. All rights reserved.
//

import UIKit

class ContactListViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  private var contactListViewModel: ContactListViewModel!
  
  override func viewDidLoad() {
      super.viewDidLoad()
      contactListViewModel = ContactListViewModel(networkViewDelegate: self)
      contactListViewModel.getContactList()
      // Do any additional setup after loading the view.
      setNavigationBar("Contacts")
      registerCell()
      tableView.delegate = self
      tableView.dataSource = self
  }
  
  func setNavigationBar(_ title: String) {
    self.navigationController?.navigationBar.backgroundColor = UIColor.white
    self.navigationController?.navigationBar.tintColor = UIColor.white
    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationItem.title = title
    self.navigationController?.setNavigationBarHidden(false, animated: false)
    self.setBackButtonTitle(" ")
  }
  
  func setBackButtonTitle(_ title: String) {
    let backItem = UIBarButtonItem()
    backItem.title = title
    self.navigationItem.backBarButtonItem = backItem
  }
  
  private func registerCell() {
    let cellClassName = "ContactTableViewCell"
    self.tableView.register(UINib(nibName: cellClassName, bundle: nil),
                            forCellReuseIdentifier: cellClassName)
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
    
  }
  
  func hideLoader() {
    
  }
  
  func showResult() {
    tableView.reloadData()
  }
}

struct ListRouter {
  static func goToDetail(withData contactData: ContactItemListModel, onNavigationController navigationController: UINavigationController?) {
    let viewModel = ContactDetailViewModel(detailUrl: contactData.url)
    let viewController = ContactDetailViewController(viewModel: viewModel)
    navigationController?.pushViewController(viewController, animated: true)
  }
}
