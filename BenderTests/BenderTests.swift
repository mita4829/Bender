//
//  BenderTests.swift
//  BenderTests
//
//  Created by Michael Tang on 12/23/16.
//  Copyright © 2016 Michael Tang. All rights reserved.
//

import XCTest
@testable import Bender

class BenderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(!canBeIntegerModel(value: 3.14159))
        XCTAssert(canBeIntegerModel(value: 3.0))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func canBeIntegerModel(value:Float) -> Bool{
        let testDouble:Bool = value.truncatingRemainder(dividingBy: 1) == 0
        return testDouble
    }
    
}
