//
//  ShoppingListScreen.swift
//  ShlistUITests
//
//  Created by Bojan Peric on 1/23/23.
//  Copyright © 2023 Pavel Lyskov. All rights reserved.
//

import XCTest

class ShoppingListScreen: BaseScreen {
  
  // Screen Elements
  let navigationBar = XCUIApplication().navigationBars["Shopping list"]
  let enterToAddSearchField = XCUIApplication().navigationBars["Shopping list"].searchFields["Enter to add..."]
  let moreButton = XCUIApplication().navigationBars["Shopping list"].buttons["moreButton"]
  let searchResult = XCUIApplication().tables["Search results"]
  let addItemCloseButton = XCUIApplication().navigationBars["Shopping list"].buttons["Close"]
  let clearListButton = XCUIApplication().otherElements.buttons["Clear list"]
  
  // ListItem available actions
  enum ListItem {
    case category, deleteFromDictionary, remove
  }
  
  // Selecting ListItem action
  func listItemOption(listItem: ListItem) -> String {
    switch (listItem) {
    case .category:
      return "Category"
    case .deleteFromDictionary:
      return "Delete from Dictionary"
    case .remove:
      return "Remove"
    }
  }
  
  // Select the result from the list of available items based on the inputed string
  func selectSearchResult(result: String) -> XCUIElement {
    return searchResult.staticTexts[result]
  }
  
  // Add single item to the Shopping List
  func addShopListItem(item: String) -> Void {
    self.enterToAddSearchField.tap()
    self.enterToAddSearchField.tap()
    self.enterToAddSearchField.typeText(item)
    self.selectSearchResult(result: item).tap()
    self.addItemCloseButton/*@START_MENU_TOKEN@*/.tap()/*[[".tap()",".press(forDuration: 1.6);"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
  }
  
  // Add multiple items to the Shopping List
  func addMultipleShopListItems(items: [String]) -> Void {
    for item in items {
      addShopListItem(item: item)
    }
  }
  
  // Delete single item from the Shopping List
  func deleteSingleShopListItem(item: String) -> Bool {
    if (app.tables.staticTexts[item].exists) {
      let listItemOption = listItemOption(listItem: ListItem.remove)
      app.tables.staticTexts[item].swipeLeft()
      app.tables.buttons[listItemOption].tap()
      return true
    } else {
      log("deleteShopItem: Item doesn't exist in shopping items list!")
      return false
    }
  }
  
  // Delete multiple items from the Shopping List
  func deleteMultipleShopList() -> Void {
    let listItemOption = listItemOption(listItem: ListItem.remove)
    while (app.tables.staticTexts.element(boundBy: 1).exists) {
      app.tables.staticTexts.element(boundBy: 1).swipeLeft()
      app.tables.buttons[listItemOption].tap()
    }
  }
  
  // Clear the whole Shopping List
  func clearList() -> Void {
    self.moreButton.tap()
    self.clearListButton.tap()
  }
  
}
