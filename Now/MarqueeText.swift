import UIKit

class MarqueeText: UIView {
  var text: CTLine!
  var padding: CGFloat!

  convenience init(frame: CGRect, text: CTLine, padding: CGFloat) {
    self.init(frame: CGRectMake(frame.origin.x, -padding, frame.width, frame.height + (padding * 2)))

    self.text = text
    self.padding = padding
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.opaque = false;
  }

  required init?(coder decoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func drawRect(rect: CGRect) {
    super.drawRect(rect)
    
    if let context = UIGraphicsGetCurrentContext() {
      // Flip the context coordinates.

      CGContextTranslateCTM(context, 0, self.bounds.size.height - self.padding);
      CGContextScaleCTM(context, 1.0, -1.0);
      
      // Set the text matrix.
      
      CGContextSetTextMatrix(context, CGAffineTransformIdentity);

      // Draw the line.
      
      CTLineDraw(text, context)
    }
  }
}
