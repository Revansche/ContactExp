//
//  MutateContactViewModel.swift
//  ContactExp
//
//  Created by Ghean Ginanjar on 22/03/19.
//  Copyright © 2019 Ghean Ginanjar. All rights reserved.
//

import Foundation
import Alamofire

class MutateContactViewModel {
  
  private var action: Action
  private var networkViewDelegate: NetworkViewProtocol?
  private var contactDetail: ContactsModel
  
  var contactFirstName: String {
    set {
      contactDetail.firstName = newValue
    }
    get {
      return contactDetail.firstName
    }
  }
  
  var contactLastName: String {
    set {
      contactDetail.lastName = newValue
    }
    get {
      return contactDetail.lastName
    }
  }
  
  var contactPhoneNumber: String {
    set {
      contactDetail.phoneNumber = newValue
    }
    get {
      return contactDetail.phoneNumber
    }
  }
  
  var contactEmail: String {
    set {
      contactDetail.email = newValue
    }
    get {
      return contactDetail.email
    }
  }
  
  var contactImageLink: String {
    return contactDetail.profilePic
  }
  
  func setNetworkViewDelegate(object: NetworkViewProtocol) {
    self.networkViewDelegate = object
  }
  
  init(action: Action, contactModel: ContactsModel) {
    self.action = action
    self.contactDetail = contactModel
  }
  
  func proceedAction() {
    do {
      let encoder = JSONEncoder()
      encoder.keyEncodingStrategy = .convertToSnakeCase
      let encodedContact = try encoder.encode(contactDetail)
      if let serialized = try JSONSerialization.jsonObject(with: encodedContact, options: .allowFragments) as? [String: Any] {
        action.executeAPIAction(with: serialized, networkViewDelegate: networkViewDelegate)
      } else {
        print("Error serialized it to JSON([String: Any]]")
      }
      
    } catch {
      print("What error?")
    }
  }
}
