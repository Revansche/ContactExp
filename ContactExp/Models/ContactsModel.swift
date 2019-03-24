//
//  ContactsModel.swift
//  ContactExp
//
//  Created by Ghean Ginanjar on 22/03/19.
//  Copyright © 2019 Ghean Ginanjar. All rights reserved.
//

import Foundation

class ContactsModel: Codable {
  var id: Int
  var firstName: String
  var lastName: String
  var email: String
  var phoneNumber: String
  var profilePic: String
  var favorite: Bool
  var createdAt: String
  var updatedAt: String
  
  init() {
    self.id = -1
    self.firstName = ""
    self.lastName = ""
    self.email = ""
    self.phoneNumber = ""
    self.profilePic = ""
    self.favorite = false
    self.createdAt = ""
    self.updatedAt = ""
  }
}

extension ContactsModel {
  var fullName: String {
    return firstName+" "+lastName
  }
}
