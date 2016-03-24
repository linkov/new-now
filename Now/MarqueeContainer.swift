import UIKit

class MarqueeContainer: UIView {
  var texts = [MarqueeText]()
  
  var textColor: UIColor! {
    didSet {
      if oldValue != nil {
        onColorChange()
      }
    }
  }

  private func onColorChange() {
   let renderedText = renderLine(textString, font)

    for text in texts {
      text.text = renderedText
      text.setNeedsDisplay()
    }
  }
  
  private var fontSize: CGFloat!
  private var font: CTFont!
  private var textString: String!

  convenience init(frame: CGRect, text: String, fontName: String, textColor: UIColor, padding: CGFloat) {
    self.init(frame: frame)
    
    self.textColor = textColor
    
    var offset: CGFloat = 0
    textString = text
    fontSize     = determineFontSize(fontName, frame.height, padding)
    font = CTFontCreateWithName(fontName, fontSize, nil)
    let renderedText = renderLine(textString, font)
    let textWidth    = determineTextWidth(renderedText)
    let textFrame    = CGRectMake(frame.origin.x, frame.origin.y, textWidth, frame.height)
    
    for _ in 0..<3 {
      let marqueeText = MarqueeText(frame: CGRectOffset(textFrame, offset, 0), text: renderedText, padding: padding)
      addSubview(marqueeText)

      texts.append(marqueeText)
      
      offset += marqueeText.frame.width
    }
    
    self.frame.size = CGSizeMake(textWidth * 3, self.frame.height)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder decoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func determineFontSize(fontName: String, _ height: CGFloat, _ padding: CGFloat) -> CGFloat {
    let font      = CTFontCreateWithName(fontName, 1, nil)
    let capHeight = CTFontGetCapHeight(font)
    
    return CGFloat(height * capHeight)
  }
  
  private func determineTextWidth(line: CTLine) -> CGFloat! {
    let bounds     = CTLineGetImageBounds(line, nil)
    let whitespace = CTLineGetTrailingWhitespaceWidth(line)
    
    return bounds.width + CGFloat(whitespace)
  }
  
  private func renderLine(text: String, _ font: CTFont) -> CTLine {
    let attributes: [String: AnyObject] = [
      NSForegroundColorAttributeName: self.textColor.CGColor, NSFontAttributeName: font, NSKernAttributeName: 15.0
    ]
    
    let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
    
    return CTLineCreateWithAttributedString(attributedString)
  }
}
