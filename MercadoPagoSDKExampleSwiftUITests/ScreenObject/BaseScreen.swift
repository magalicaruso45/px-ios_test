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
    let PREVENTIVE_WAIT: Double = 3
    let SWIPE_INTERVAL : Double = 1
    let SWIPE_ATTEMPTS : Int = 3
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
                            safe: Bool = false,
                            count: Int = 0,
                            hittable: Bool = false) -> Bool {
        let expect = expectations(for: element, hittable: hittable)
        let waitingTime = count == 0 ? time : SWIPE_INTERVAL
        let result: XCTWaiter.Result =
            XCTWaiter().wait(for: expect,
                             timeout: waitingTime)

        print("attempt to get item")
        if count >= SWIPE_ATTEMPTS {
            print("final error")
            let totalTimeElapsed = time + Double(SWIPE_ATTEMPTS) * SWIPE_INTERVAL
            XCTFail("Attempt to retrive \(element.self.description) failed after \(totalTimeElapsed) seconds and \(SWIPE_ATTEMPTS) swipes")
        }

        if (safe && result == .completed) || (element.exists && element.isHittable) {
            return true
        }

        //try again
        self.swipeUp()
        return waitForElement(element: element, time: time, safe: safe, count: count + 1, hittable: hittable)
    }

    @discardableResult
    func checkFor(element: XCUIElement) -> Bool {
        let expect = expectations(for: element, hittable: false)
        let result: XCTWaiter.Result = XCTWaiter().wait(for: expect,timeout: PREVENTIVE_WAIT)
        return result == .completed
    }

    @discardableResult
    func waitFor(element: XCUIElement, time: Double? = nil, terminate: Bool = true) -> Bool {
        return waitForElement(element: element, time: time ?? PREVENTIVE_WAIT, safe: !terminate)
    }

    private func expectations(for element: XCUIElement, hittable: Bool) -> [XCTestExpectation] {
        let exists = NSPredicate(format: "exists = 1")
        let isHittable = NSPredicate(format: "hittable = true")
        let predicate1 = XCTNSPredicateExpectation(predicate: exists, object: element)
        let predicate2 = XCTNSPredicateExpectation(predicate: isHittable, object: element)
        var expectations = [predicate1]
        if hittable {
            expectations.append(predicate2)
        }
        return expectations
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

    func tap(_ element: XCUIElement) {
        if  !element.exists || !element.isHittable  {
            waitForElement(element: element, time: 0, safe: false, hittable: false)
        }
        element.tap()
    }

    @discardableResult
    func swipeUp<T: BaseScreen>(type: T? = nil) -> T {
        print("swiping up")
        return swipe(type: type, direction: .up)
    }

    @discardableResult
    func swipeDown<T: BaseScreen>(type: T? = nil) -> T {
        print("swiping down")
        return swipe(type: type, direction: .down)
    }

    @discardableResult
    func swipe<T: BaseScreen>(type: T? = nil, direction : SwipeDirection) -> T {
        let app = XCUIApplication()
        let allElements = app.descendants(matching: .other)
        var allHittableElements = [XCUIElement]()
        for i in 0..<allElements.count {
            let element = allElements.element(boundBy: i)
            if element.isHittable {
                allHittableElements.append(element)
            }
        }
        allHittableElements.first?.gentleSwipe(direction)
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
