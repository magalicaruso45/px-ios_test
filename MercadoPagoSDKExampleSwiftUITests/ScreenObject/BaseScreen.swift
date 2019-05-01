//
//  BaseScreen.swift
//  PXFlowUITests
//
//  Created by Demian Tejo on 12/3/18.
//  Copyright © 2018 MercadoPago. All rights reserved.
//

import XCTest
import UIKit

public protocol BaseScreenProtocol {
    func waitForElements()
}

open class BaseScreen : BaseScreenProtocol {
    let TIME_OUT : Double = 10 // Seconds
    public init() {
        waitForElements()
    }

    func validate(validationAssets:((BaseScreen)->Void)) -> Self {
        validationAssets(self)
        return self
    }

    open func waitForElements() {
        //fatalError("All Screens Must Override this Method")
    }

    func exist(element: XCUIElement) -> Bool{
        return element.exists
    }
}

// MARK: Loading screen helpers
public extension BaseScreen {
    @discardableResult
    func waitForElement(element:XCUIElement,
                            time: Double,
                            safe: Bool = false) -> Bool {
        let expect = expectation(for: element)
        let result: XCTWaiter.Result =
            XCTWaiter().wait(for: [expect],
                             timeout: time)

        print("attempt to get item")
        if !safe && result != .completed {
            print("first opportunity")
            self.swipeUp()
            return lastWaitForElement(element: element, time: time, safe: safe)
        }
        return result == .completed
    }

    func lastWaitForElement(element:XCUIElement,
                            time: Double,
                            safe: Bool = false) -> Bool {

        print("attempt 2")
        let expect = expectation(for: element)
        let result: XCTWaiter.Result =
            XCTWaiter().wait(for: [expect],
                             timeout: time)
        if !safe && result != .completed {
            print("final error")
            XCTFail("Attempt failed after \(time * 2) seconds")
        }
        return result == .completed
    }

    @discardableResult
    func waitFor(element: XCUIElement, time: Double = 5, terminate: Bool = true) -> Bool {
        return waitForElement(element: element, time: time, safe: !terminate)
    }

    private func expectation(for element: XCUIElement) -> XCTestExpectation {
        let exists = NSPredicate(format: "exists = 1")
        return XCTNSPredicateExpectation(predicate: exists, object: element)
    }

}

// MARK: Take elements from screen
public extension BaseScreen {
    func findAll(_ type: XCUIElement.ElementType) -> XCUIElementQuery {
        return XCUIApplication().descendants(matching: type)
    }
    func cell(_ text: String) -> XCUIElement {
        return findAll(.cell).containing(.staticText, identifier: text).element
    }
    func textField(_ text: String) -> XCUIElement {
        return  XCUIApplication().textFields[text]
    }
    func toolbarButton(_ text: String) -> XCUIElement {
        return XCUIApplication().toolbars.buttons[text]
    }
    func cellNumber(_ row : Int)  -> XCUIElement{
        return  XCUIApplication().cells.allElementsBoundByIndex[row]
    }
    func cellButton(_ text: String) -> XCUIElement {
        return button(text)
    }
    func button(_ text: String) -> XCUIElement {
        return XCUIApplication().buttons[text].firstMatch
    }
    func switchElement(_ text: String) -> XCUIElement {
        return XCUIApplication().switches[text].firstMatch
    }
    func element(_ text: String) -> XCUIElement {
        return XCUIApplication().staticTexts[text].firstMatch
    }
    func labelContains(_ text: String) -> XCUIElement {
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", text)
        let result = XCUIApplication().staticTexts.containing(predicate)
        let element = XCUIApplication().staticTexts[result.element.label]
        return element
    }
    func otherElement(_ text: String) -> XCUIElement {
        return XCUIApplication().otherElements[text].firstMatch
    }
    func imageView(_ text: String) -> XCUIElement {
        return XCUIApplication().images[text].firstMatch
    }
    func getBackButton() -> XCUIElement {
        return XCUIApplication().navigationBars.buttons.element(boundBy: 0)
    }
    func stepper(_ text: String) -> XCUIElement {
        return XCUIApplication().steppers[text].firstMatch
    }
    func firstSecureTextField() -> XCUIElement {
        return XCUIApplication().secureTextFields.firstMatch
    }
}

// MARK: UI Controls
public extension BaseScreen {
    @discardableResult
    func swipeUp<T: BaseScreen>(class: T? = nil) -> T {
        print("swiping up")
        let scrollViewsQuery = XCUIApplication().scrollViews
        let elementQuery = scrollViewsQuery.otherElements.firstMatch
        elementQuery.swipeUp()
        return self as! T
    }

    @discardableResult
    func swipeDown<T: BaseScreen>(class: T? = nil) -> T {
        print("swiping down")
        let scrollViewsQuery = XCUIApplication().scrollViews
        let elementQuery = scrollViewsQuery.otherElements.firstMatch
        elementQuery.swipeDown()
        return self as! T
    }
    
    func swipeRight() {
        let scrollViewsQuery = XCUIApplication().scrollViews
        let elementQuery = scrollViewsQuery.otherElements.firstMatch
        elementQuery.swipeRight()
    }
    
    func swipeLeft() {
        let scrollViewsQuery = XCUIApplication().scrollViews
        let elementQuery = scrollViewsQuery.otherElements.firstMatch
        elementQuery.swipeLeft()
    }
}
