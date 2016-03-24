import UIKit

class MarqueeScrollView: UIScrollView {
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    if dragging {
      super.touchesBegan(touches, withEvent: event)
    } else {
      nextResponder()?.touchesBegan(touches, withEvent: event)
    }
  }
  
  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    if dragging {
      super.touchesMoved(touches, withEvent: event)
    } else {
      nextResponder()?.touchesMoved(touches, withEvent: event)
    }
  }
  
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    if dragging {
      super.touchesEnded(touches, withEvent: event)
    } else {
      nextResponder()?.touchesEnded(touches, withEvent: event)
    }
  }
}
