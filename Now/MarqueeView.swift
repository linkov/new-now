import UIKit

class MarqueeView: UIScrollView {
  var marqueeTextView: MarqueeTextView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    marqueeTextView = MarqueeTextView(text: "TEST", frame: frame)
  }

  required init?(coder decoder: NSCoder) {
    super.init(coder: decoder)
    
    marqueeTextView = MarqueeTextView(text: "NOW IS JUST RIGHT NOW", frame: frame)
    self.addSubview(marqueeTextView)
  }
  
  func animate() {
    //self.layer.removeAllAnimations()
    let duration : Double = 9 // Double(Float(images[0].frame.width - self.contentOffset.x) / speed)
    
    UIView.animateWithDuration(duration, delay: 0, options: [.CurveLinear, .AllowUserInteraction], animations: { () -> Void in
      self.contentOffset = CGPointMake(self.marqueeTextView.frame.width / 3, 0)
      }, completion: { (finished: Bool) -> Void in
        if finished {
          self.contentOffset = CGPointMake(0, 0)
          self.animate()
        } else {
          
          //println(self.currentOffsetX)
         // self.contentOffset = CGPointMake(self.currentOffsetX, 0)
          
          //self.contentOffset = CGPointMake(100, 0) //self.bounds.origin
          //self.layer.presentationLayer().bounds.origin.x
          //   println(self.layer.presentationLayer()!.contentOffset.x);
          //self.contentOffset = self.layer.presentationLayer().contentOffset // CGPointMake(self.contentOffset.x, 0)
        }
    })
  }
}