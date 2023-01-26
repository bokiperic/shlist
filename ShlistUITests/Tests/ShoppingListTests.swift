//
//  ShoppingListTests.swift
//  ShlistUITests
//
//  Created by Bojan Peric on 1/23/23.
//  Copyright © 2023 Pavel Lyskov. All rights reserved.
//

import XCTest

class ShoppingListTests: XCTestCase {
  
  let app = XCUIApplication()
  let shoppingListScreen = ShoppingListScreen()
  let itemAdd_1: String = "Butter"
  let itemAdd_2: String = "Peanut butter"
  let itemAdd_3: String = "Milk"
  let emptyListText: String = "The list is empty"
  
  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    XCUIApplication().launch()
  }
  
  override func tearDown() {
    XCUIApplication().terminate()
  }
  
  func testShoppingListScreenDisplayed() {
    XCTAssert(shoppingListScreen.navigationBar.exists)
    XCTAssert(shoppingListScreen.enterToAddSearchField.exists)
    XCTAssert(shoppingListScreen.moreButton.exists)
  }
  
  func testAddingShopListItem() {
    shoppingListScreen.addShopListItem(item: itemAdd_1)
    
    XCTAssert(app.tables.staticTexts.element(boundBy: 1).exists, "ERROR: Added list item isn't displayed in the list!")
    let itemList_1 = app.tables.staticTexts.element(boundBy: 1).label
    XCTAssert(app.tables.staticTexts["New"].exists)
    XCTAssert(app.tables.staticTexts[itemList_1].exists)
    XCTAssertEqual(itemAdd_1, itemList_1, "Items' names aren't the same!")
    shoppingListScreen.clearList()
  }
  
  func testDeleteSingleShoppingListItem() throws {
    shoppingListScreen.addShopListItem(item: itemAdd_1)
    if (shoppingListScreen.deleteSingleShopListItem(item: itemAdd_1)) {
      if (app.tables.staticTexts.element(boundBy: 1).exists) {
        XCTAssertNotEqual(app.tables.staticTexts.element(boundBy: 1).label, itemAdd_1, "The deleted item is still in the shopping list!")
      } else {
        XCTAssert(XCUIApplication().tables[emptyListText].staticTexts[emptyListText].exists)
      }
    } else {
      XCTFail("The item you wish to delete doesn't exist in the shopping list!")
    }
  }
  
  func testDeleteMultipleShoppingListItems() {
    shoppingListScreen.addMultipleShopListItems(items: [itemAdd_1, itemAdd_2, itemAdd_3])
    XCTAssert(app.tables.staticTexts[itemAdd_1].exists)
    XCTAssert(app.tables.staticTexts[itemAdd_2].exists)
    XCTAssert(app.tables.staticTexts[itemAdd_3].exists)
    shoppingListScreen.deleteMultipleShopList()
    XCTAssert(XCUIApplication().tables[emptyListText].staticTexts[emptyListText].exists)
  }
  
  func testClearShoppingList() {
    shoppingListScreen.addMultipleShopListItems(items: [itemAdd_1, itemAdd_2, itemAdd_3])
    XCTAssert(app.tables.staticTexts[itemAdd_1].exists)
    XCTAssert(app.tables.staticTexts[itemAdd_2].exists)
    XCTAssert(app.tables.staticTexts[itemAdd_3].exists)
    shoppingListScreen.clearList()
    XCTAssert(XCUIApplication().tables[emptyListText].staticTexts[emptyListText].exists)
  }
  
}
