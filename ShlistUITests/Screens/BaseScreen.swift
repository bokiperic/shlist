//
//  BaseScreen.swift
//  ShlistUITests
//
//  Created by Bojan Peric on 1/21/23.
//  Copyright © 2023 Pavel Lyskov. All rights reserved.
//

import XCTest

class Logger {
  
  func log(_ mlog: String) {
    NSLog(mlog)
  }
}

public class BaseScreen {
  
  let app = XCUIApplication()
  let log = Logger().log
  
  required init(timeout: TimeInterval = 10) {
    log("waiting \(timeout)s or \(String(describing: self)) existence")
  }
}
