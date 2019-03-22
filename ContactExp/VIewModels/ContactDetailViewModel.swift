//
//  ContactDetailViewModel.swift
//  ContactExp
//
//  Created by Ghean Ginanjar on 22/03/19.
//  Copyright © 2019 Ghean Ginanjar. All rights reserved.
//

import Foundation
import Alamofire

class ContactDetailViewModel {
  
  var detailUrl: String
  
  init(detailUrl: String) {
    self.detailUrl = detailUrl
  }
  
  func viewDidLoad() {
    getDetailData()
  }
  
  private func getDetailData() {
    let url = detailUrl
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
      }
    }
  }
}
