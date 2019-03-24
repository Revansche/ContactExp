//
//  ContactListViewModel.swift
//  ContactExp
//
//  Created by Ghean Ginanjar on 22/03/19.
//  Copyright © 2019 Ghean Ginanjar. All rights reserved.
//

import Foundation
import Alamofire

class ContactListViewModel {
  
  var contacts: [ContactItemListModel] = []
  var groupedContacts: [[ContactItemListModel]] = [[]]
  
  private weak var delegate: NetworkViewProtocol?
  var sectionIndexTitleLetter: [String] = []
  
  init(networkViewDelegate: NetworkViewProtocol) {
    self.delegate = networkViewDelegate
  }
  
  func getContactList() {
    //WHY? WHY DO I NEED TO ADD .JSON????
    delegate?.showLoader()
    let url = Endpoints.baseURL+Endpoints.contactPath+".json"
    Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON() {
      [weak self] response in
      guard let `self` = self else {
        return
      }
      switch response.result {
      case .success:
          if let data = response.data {
            do {
              let decoder = JSONDecoder()
              decoder.keyDecodingStrategy = .convertFromSnakeCase
              self.contacts = try decoder.decode([ContactItemListModel].self, from: data)
              self.sortContacts()
            } catch DecodingError.keyNotFound(let key, let context) {
              print("error key not found \(key) and context \(context)")
            } catch DecodingError.dataCorrupted(let context) {
              print("error context \(context)")
            } catch DecodingError.typeMismatch(let type, let context){
              print("error type not found \(type) and context \(context)")
            } catch {
              print("error")
            }
        }
      case .failure( _):
        return //Show error
      }
    }
  }
  
  private func sortContacts() {
    
    let sortedContacts = contacts.sorted(by: {
      let firstCase = $0.firstName.uppercased()
      let secondCase = $1.firstName.uppercased()
      return firstCase < secondCase
    }) // sort the Array first.
    
    let filteredContacts = filteredFirstNames(sortedContact: sortedContacts)
    
    let groupedContacts = filteredContacts.reduce([[ContactItemListModel]]()) {
      guard var last = $0.last else { return [[$1]] }
      var collection = $0
      if last.first!.firstName.uppercased().first == $1.firstName.uppercased().first {
        last += [$1]
        collection[collection.count - 1] = last
      } else {
        collection += [[$1]]
      }
      return collection
    }    
    self.groupedContacts = groupedContacts
    sectionIndexTitleLetter = getSectionIndexTitle()    
    self.delegate?.showResult()
  }
  
  private func filteredFirstNames(sortedContact: [ContactItemListModel]) -> [ContactItemListModel] {
    let filteredContacts = sortedContact.filter {
      guard let _ = Int($0.firstName.prefix(1)) else {
        return true
      }
      return false
    }
    return filteredContacts
  }
  
  private func getSectionIndexTitle() -> [String] {
    return groupedContacts.map{String($0[0].firstName.capitalized.first!)}
  }
  
}
