//
//  ContactsModel.swift
//  ContactExp
//
//  Created by Ghean Ginanjar on 22/03/19.
//  Copyright © 2019 Ghean Ginanjar. All rights reserved.
//

import Foundation

class ContactsModel: Codable {
  var firstName: String
  var lastName: String
  var email: String
  var phoneNumber: String
  var profilePic: String
  var favorite: Bool
  var createdAt: String
  var updateAt: String
}

extension ContactsModel {
  var fullName: String {
    return firstName+" "+lastName
  }
}
