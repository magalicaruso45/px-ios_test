import Foundation
import XCTest

extension XCUIElement
{
    enum Direction : Int {
        case up, down, left, right
    }

    func gentleSwipe(_ direction : Direction, half : CGFloat = 0.5, adjustment : CGFloat = 0.25, offset : CGFloat = -0.1, pressDuration : TimeInterval = 0.05) {


        let lessThanHalf = half - adjustment
        let moreThanHalf = half + adjustment

        let centre = self.coordinate(withNormalizedOffset: CGVector(dx: half, dy: half + offset))
        let aboveCentre = self.coordinate(withNormalizedOffset: CGVector(dx: half, dy: lessThanHalf + offset))
        let belowCentre = self.coordinate(withNormalizedOffset: CGVector(dx: half, dy: moreThanHalf + offset))
        let leftOfCentre = self.coordinate(withNormalizedOffset: CGVector(dx: lessThanHalf, dy: half))
        let rightOfCentre = self.coordinate(withNormalizedOffset: CGVector(dx: moreThanHalf, dy: half))

        switch direction {
        case .up:
            centre.press(forDuration: pressDuration, thenDragTo: aboveCentre)
            break
        case .down:
            centre.press(forDuration: pressDuration, thenDragTo: belowCentre)
            break
        case .left:
            centre.press(forDuration: pressDuration, thenDragTo: leftOfCentre)
            break
        case .right:
            centre.press(forDuration: pressDuration, thenDragTo: rightOfCentre)
            break
        }
    }
}
