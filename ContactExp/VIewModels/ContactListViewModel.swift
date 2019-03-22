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
  
  func getContactList() {
    //WHY? WHY DO I NEED TO ADD .JSON????
    let url = Endpoints.baseURL+Endpoints.contactPath+".json"
    Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON() {
      [weak self] response in
      guard let `self` = self else {
        return
      }
      
      print("Request: \(String(describing: response.request))")   // original url request
      print("Response: \(String(describing: response.response))") // http url response
      print("Result: \(response.result)")                         // response serialization result
      
      if let json = response.result.value {
        print("JSON: \(json)") // serialized json response
      }
      
      if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
        print("Data: \(utf8Text)") // original server data as UTF8 string
        do {
          let decoder = JSONDecoder()
          decoder.keyDecodingStrategy = .convertFromSnakeCase
          self.contacts = try decoder.decode([ContactItemListModel].self, from: data)
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
    }
  }
}
