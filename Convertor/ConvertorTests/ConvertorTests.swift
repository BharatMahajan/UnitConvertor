//
//  ConvertorTests.swift
//  ConvertorTests
//
//  Created by Bharat Mahajan on 10/01/19.
//  Copyright © 2019 BharatMahajan. All rights reserved.
//

import XCTest
@testable import Convertor

class ConvertorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()

        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testInputButton() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! ViewController
        let _ = vc.view
        
        vc.selectUnitValueAction(vc.btnInputUnit)
        XCTAssertEqual(vc.selectedInputUnit, -1)
    }
    
    func testOutputButton() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! ViewController
        let _ = vc.view

        vc.selectUnitValueAction(vc.btnOutputUnit)
        XCTAssertEqual(vc.selectedOutputUnit, -1)
    }
    
    func testConvertButton(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! ViewController
        let _ = vc.view

        XCTAssertEqual(vc.selectedOutputUnit, -1)
        XCTAssertEqual(vc.selectedInputUnit, -1)
        XCTAssertEqual(vc.outputTxtValue, 0.0)
        XCTAssertEqual(vc.inputTxtValue, 0.0)
    }
    
    func testTextField() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! ViewController
        let _ = vc.view
        
        vc.loadViewIfNeeded()
        let field = vc.txtInputValue
        let result = field?.delegate?.textField!(field!, shouldChangeCharactersIn: NSMakeRange(0, 3), replacementString: "$")
        XCTAssertFalse(result!)
    }
    
    func testPerformanceExample() {
        self.measure {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateInitialViewController() as! ViewController
            let _ = vc.view

            vc.convertValue(vc.btnConvert)
        }
    }
    
}
