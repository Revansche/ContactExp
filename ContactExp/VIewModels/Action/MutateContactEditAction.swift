//
//  MutateContactEditAction.swift
//  ContactExp
//
//  Created by Ghean Ginanjar on 24/03/19.
//  Copyright © 2019 Ghean Ginanjar. All rights reserved.
//

import Foundation
import Alamofire

struct MutateContactEditAction: Action {
  func executeAPIAction(with serializedContact: [String: Any], networkViewDelegate: NetworkViewProtocol?) {
    networkViewDelegate?.showLoader()
    var contactParams = serializedContact
    guard let contactId = contactParams["id"] as? Int else {
      return
    }
    
    contactParams.removeValue(forKey: "id")
    let url = Endpoints.baseURL+Endpoints.contactPath+"/\(contactId)"
    Alamofire.request(url, method: .put, parameters: contactParams, encoding: JSONEncoding.default, headers: nil).responseJSON() {
      response in      
      //THIS IS WEIRD... IT COUNTED AS A FAILURE BUT THE RECORD CHANGED
      print("Result: \(response.result)")                         // response serialization result
      if let json = response.result.value {
        print("JSON: \(json)") // serialized json response
      }
      networkViewDelegate?.showResult()
    }
  }
}
