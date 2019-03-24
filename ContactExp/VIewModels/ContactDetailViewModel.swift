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
  
  private var contactDetail: ContactsModel?
  private var networkViewDelegate: NetworkViewProtocol?
  private var detailUrl: String
  
  var contactImage: String {
    return contactDetail?.profilePic ?? ""
  }
  var contactFullName: String {
    return contactDetail?.fullName ?? ""
  }
  var contactIsFavorite: Bool {
    return contactDetail?.favorite ?? false
  }
  var contactEmail: String {
    return contactDetail?.email ?? ""
  }
  var contactPhoneNumber: String {
    return contactDetail?.phoneNumber ?? ""
  }
  
  init(detailUrl: String) {
    self.detailUrl = detailUrl
  }
  
  init(contactDetail: ContactsModel?) {
    self.contactDetail = contactDetail
    self.detailUrl = ""
  }
  
  func setNetworkViewDelegate(object: NetworkViewProtocol) {
    self.networkViewDelegate = object
  }
  
  func viewWillAppear() {
    getDetailData()
  }
  
  func getContactObject() -> ContactsModel {
    return contactDetail ?? ContactsModel()
  }
  
  private func getDetailData() {
    networkViewDelegate?.showLoader()
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
      
      if let data = response.data {
        do {
          let decoder = JSONDecoder()
          decoder.keyDecodingStrategy = .convertFromSnakeCase
          self.contactDetail = try decoder.decode(ContactsModel.self, from: data)
          self.networkViewDelegate?.showResult()
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
