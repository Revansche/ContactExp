//
//  ContactItemListModel.swift
//  ContactExp
//
//  Created by Ghean Ginanjar on 22/03/19.
//  Copyright © 2019 Ghean Ginanjar. All rights reserved.
//

import Foundation

struct ContactItemListModel: Codable {
  var id: Int
  var firstName: String
  var lastName: String
  var profilePic: String
  var favorite: Bool
  var url: String
}

extension ContactItemListModel {
  var fullName: String {
    return firstName+" "+lastName
  }
}
