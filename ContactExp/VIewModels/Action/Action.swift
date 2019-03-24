//
//  Action.swift
//  ContactExp
//
//  Created by Ghean Ginanjar on 22/03/19.
//  Copyright © 2019 Ghean Ginanjar. All rights reserved.
//

import Foundation

protocol Action {
  func executeAPIAction(with serializedContact: [String: Any], networkViewDelegate: NetworkViewProtocol?)
}
