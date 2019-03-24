//
//  ContactExpUITests.swift
//  ContactExpUITests
//
//  Created by Ghean Ginanjar on 22/03/19.
//  Copyright © 2019 Ghean Ginanjar. All rights reserved.
//

import XCTest

class ContactExpUITests: XCTestCase {
  var app: XCUIApplication!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
      
        app = XCUIApplication()
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
      // We send a command line argument to our app,
      // to enable it to reset its state
      app.launchArguments.append("--uitesting")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
  
    func testLaunch() {
      app.launch()
      XCTAssertTrue(app.isDisplayingContactList)
    }
  
    func testInvokeDetail() {
      app.launch()
      XCTAssertTrue(app.isDisplayingContactList)
      let contactListTable = app.tables["contactListTable"]
      XCTAssert(contactListTable.exists)
      contactListTable.cells.element(boundBy: 0).tap()
      XCTAssert(app.isDisplayingDetailView)
    }
  
    func testInvokeAddContact() {
      app.launch()
      XCTAssertTrue(app.isDisplayingContactList)
      let rightNavBarButton = app.navigationBars.buttons["navbarRightItem"]
      XCTAssert(rightNavBarButton.exists)
      rightNavBarButton.tap()
      XCTAssert(app.isDisplayingMutateView)
      let firstNameField = app.textFields["firstNameField"]
      XCTAssert(firstNameField.exists)
      let firstNameFieldValue = firstNameField.value as! String
      XCTAssert(firstNameFieldValue.isEmpty)
    }
}

extension XCUIApplication {
  var isDisplayingContactList: Bool {
    return otherElements["contactListView"].exists
  }
  
  var isDisplayingDetailView: Bool {
    return otherElements["contactDetailView"].exists
  }
  
  var isDisplayingMutateView: Bool {
    return otherElements["contactMutateView"].exists
  }
}
