//
//  JSONComparatorTests.swift
//  JSONComparatorTests
//
//  Created by Swift Tuto on 03/02/16.
//  Copyright © 2016 Swift Tuto. All rights reserved.
//

import XCTest
import Freddy
import SwiftyJSON

class JSONComparatorTests: XCTestCase {
  static let iterationCount = 1000
  static var data: NSData?  = nil

  override class func setUp() {
    var persons: [[String: AnyObject]] = []

    for i in 0 ..< iterationCount {
      let person: [String: AnyObject] = [
        "firstname": "Firstname \(i)",
        "lastname": "Lastname \(i)",
        "age": i
      ]

      persons.append(person)
    }

    do {
      data = try NSJSONSerialization.dataWithJSONObject(persons, options: .PrettyPrinted)
    }
    catch {}
  }

  func testNativePerformance() {
    guard let data = JSONComparatorTests.data else {
      return XCTFail("Data should not be empty")
    }

    self.measureBlock {
      do {
        let _ = try NSJSONSerialization.JSONObjectWithData(data, options: [])
      }
      catch let error {
        XCTFail("\(error)")
      }
    }
  }

  func testSwiftyJSONPerformance() {
    guard let data = JSONComparatorTests.data else {
      return XCTFail("Data should not be empty")
    }

    self.measureBlock {
      let _ = SwiftyJSON.JSON(data: data)
    }
  }

  func testFreddyPerformance() {
    guard let data = JSONComparatorTests.data else {
      return XCTFail("Data should not be empty")
    }
    
    self.measureBlock {
      do {
        let _ = try Freddy.JSON(data: data)
      } catch {
        XCTFail("\(error)")
      }
    }
  }
  
}
