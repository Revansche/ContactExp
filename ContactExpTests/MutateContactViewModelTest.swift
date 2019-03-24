//
//  MutateContactViewModelTest.swift
//  ContactExpTests
//
//  Created by Ghean Ginanjar on 24/03/19.
//  Copyright © 2019 Ghean Ginanjar. All rights reserved.
//

import XCTest
@testable import ContactExp

class MutateContactViewModelTest: XCTestCase {
    var action: Action!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        action = MutateContactAddAction()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEmptyInitialization() {
        let contactModel = ContactsModel()
        let viewModel = MutateContactViewModel(action: action, contactModel: contactModel)
        XCTAssert(viewModel.contactEmail.isEmpty)
        XCTAssert(viewModel.contactLastName.isEmpty)
        XCTAssert(viewModel.contactFirstName.isEmpty)
        XCTAssert(viewModel.contactPhoneNumber.isEmpty)
        XCTAssert(viewModel.contactImageLink.isEmpty)
    }
  
    func testExistContactInitializer() {
      let contactModel = ContactsModel()
      contactModel.firstName = "John"
      contactModel.lastName = "Cena"
      contactModel.profilePic = "/image"
      let viewModel = MutateContactViewModel(action: action, contactModel: contactModel)
      XCTAssert(!viewModel.contactLastName.isEmpty)
      XCTAssert(!viewModel.contactFirstName.isEmpty)
      XCTAssert(!viewModel.contactImageLink.isEmpty)
      XCTAssert(viewModel.contactPhoneNumber.isEmpty)
    }
  
  func testMutateContactViaVM() {
    let contactModel = ContactsModel()
    let viewModel = MutateContactViewModel(action: action, contactModel: contactModel)
    viewModel.contactFirstName = "John"
    viewModel.contactLastName = "Cena"
    viewModel.contactPhoneNumber = "08555"
    viewModel.contactEmail = "BlaBla"
    XCTAssert(!viewModel.contactEmail.isEmpty)
    XCTAssert(!viewModel.contactLastName.isEmpty)
    XCTAssert(!viewModel.contactFirstName.isEmpty)
    XCTAssert(!viewModel.contactPhoneNumber.isEmpty)
    XCTAssert(viewModel.contactImageLink.isEmpty)
  }
}
