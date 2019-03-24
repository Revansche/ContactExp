//
//  MutateContactAddAction.swift
//  ContactExp
//
//  Created by Ghean Ginanjar on 22/03/19.
//  Copyright © 2019 Ghean Ginanjar. All rights reserved.
//

import Foundation
import Alamofire

struct MutateContactAddAction: Action {
  func executeAPIAction(with serializedContact: [String: Any], networkViewDelegate: NetworkViewProtocol?) {
    networkViewDelegate?.showLoader()
    var contactParams = serializedContact
    contactParams.removeValue(forKey: "id")
    let url = Endpoints.baseURL+Endpoints.contactPath
    Alamofire.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: nil).responseData() {
      response in
      print("Result: \(response.result)")                         // response serialization result
      
      if let json = response.result.value {
        print("JSON: \(json)") // serialized json response
      }
      
      if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
        print(utf8Text)
      }
      networkViewDelegate?.showResult()
    }
  }
}
