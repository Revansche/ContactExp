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
  
  private var contactListViewModel: ContactListViewModel = ContactListViewModel()
  
  override func viewDidLoad() {
      super.viewDidLoad()
      contactListViewModel.getContactList()
      // Do any additional setup after loading the view.
  }
  
  private func registerCell() {
    
  }
}

extension ContactListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
}
