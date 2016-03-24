import UIKit

class MarqueeTextView: UIView {
  var glyphs = [UILabel]()
  
  required init?(coder decoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(text: String, frame: CGRect) {
    super.init(frame: frame)
    
    var offset: CGFloat = 0
    
    for character in "\(text) - \(text) - \(text) - ".characters {
      let label = UILabel(frame: CGRectMake(offset, 0, 200, frame.height))
      label.text = String(character)
      label.font = UIFont.systemFontOfSize(300)
      label.sizeToFit()
      
      self.addSubview(label)
      glyphs.append(label)
      
      offset += label.bounds.width
    }
    
    self.frame = CGRectMake(0, frame.origin.y, offset, frame.height)
  }

  func setColor(color: UIColor) {
    let q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
    
    dispatch_async(q) {
    for glyph in self.glyphs/*[24..<27]*/ {
      dispatch_async(dispatch_get_main_queue()) {
        glyph.textColor = color
      //glyph.setNeedsDisplay()
        print("1")

      }
      print("2")

      //sleep(1)
    }
    
  }
  }
  
  private func getProperFontSize(h: CGFloat) -> CGFloat {
    let font = CTFontCreateWithName("Helvetica Neue", 1.0, nil);
    let size = CTFontGetCapHeight(font)
    
    return CGFloat(h / size * 0.85)
  }
}
 