import UIKit

extension CGRect {
    /** Creates a rectangle with the given center and dimensions
    - parameter center: The center of the new rectangle
    - parameter size: The dimensions of the new rectangle
     */
    init(center: CGPoint, size: CGSize) {
        self.init(x: round(center.x - 0.5 * size.width),
                  y: round(center.y - 0.5 * size.height),
                  width: round(size.width),
                  height: round(size.height))
    }
    
    /** the coordinates of this rectangles center */
    var center: CGPoint {
        get { return CGPoint(centerX, centerY) }
        set { centerX = round(newValue.x); centerY = round(newValue.y) }
    }
    
    /** the x-coordinate of this rectangles center
    - note: Acts as a settable midX
    - returns: The x-coordinate of the center
     */
    var centerX: CGFloat {
        get { return midX }
        set { origin.x = round(newValue - width * 0.5) }
    }
    
    /** the y-coordinate of this rectangles center
     - note: Acts as a settable midY
     - returns: The y-coordinate of the center
     */
    var centerY: CGFloat {
        get { return midY }
        set { origin.y = round(newValue - height * 0.5) }
    }
    
    // MARK: - "with" convenience functions
    
    /** Same-sized rectangle with a new center
    - parameter center: The new center, ignored if nil
    - returns: A new rectangle with the same size and a new center
     */
}

