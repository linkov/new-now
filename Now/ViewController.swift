import UIKit
import QuartzCore;

let baseText = "THIS VERY MOMENT HAS ALREADY BECOME THE PAST – "
let fontName = "ProximaNovaCond-Semibold"
let textPadding: CGFloat = 10

class ViewController: UIViewController, UIScrollViewDelegate {
  @IBOutlet weak var scrollView: UIScrollView!
  
  let minScale: CGFloat = 0.6
  var maxScale: CGFloat = 1.0

  var blackTextContainer: MarqueeContainer!
  var whiteTextContainer: MarqueeContainer!
  
  @IBAction func invert(sender: UITapGestureRecognizer) {
    invertColor()
  }

  private func invertColor() {
    if whiteTextContainer.hidden {
      whiteTextContainer.hidden = false
      blackTextContainer.hidden = true
      self.view.backgroundColor = UIColor.blackColor()
    } else {
      whiteTextContainer.hidden = true
      blackTextContainer.hidden = false
      self.view.backgroundColor = UIColor.whiteColor()
    }
  }
  
  var lastScale: CGFloat = 1.0

  @IBAction func pinch(sender: UIPinchGestureRecognizer) {
 
    if (sender.state == UIGestureRecognizerState.Began) {
      lastScale = sender.scale
    }
    
    if (sender.state == UIGestureRecognizerState.Began || sender.state == UIGestureRecognizerState.Changed) {
      applyScale(sender.scale)
      
      // Store the previous scale factor for the next pinch gesture call.
      
      lastScale = sender.scale
    }
  }

  func applyScale(scale: CGFloat) {
    let currentWidth  = whiteTextContainer.frame.width
    let currentOffset = scrollView.contentOffset.x
    
    // Begin scaling
    
    let currentTransform = whiteTextContainer.transform;
    let currentScale = whiteTextContainer.layer.valueForKeyPath("transform.scale") as! CGFloat
    
    // Limit factors.
    
    var newScale = 1 - (lastScale - scale)
    
    newScale = min(newScale, maxScale / currentScale);
    newScale = max(newScale, minScale / currentScale);
  
    currentMarqueeAnimationDuration = NSTimeInterval(CGFloat(currentMarqueeAnimationDuration) * newScale)// NSTimeInterval(CGFloat(marqueeAnimationDuration) * max(min(maxScale, sender.scale), minScale))

    // Apply scale.
    
    let newTransform = CGAffineTransformScale(currentTransform, newScale, newScale);
    whiteTextContainer.transform = newTransform
    //blackTextContainer.transform = newTransform
    
    // Reposition text.
    
    let newFrame = CGRectMake(0, whiteTextContainer.frame.origin.y, whiteTextContainer.frame.width, whiteTextContainer.frame.height)
    whiteTextContainer.frame = newFrame
  //  blackTextContainer.frame = newFrame
    
    // Reposition scroll view.
    
    self.scrollView.contentSize   = CGSizeMake(whiteTextContainer.frame.width, self.scrollView.frame.height)
    self.scrollView.contentOffset = CGPointMake((whiteTextContainer.frame.width * (currentOffset + (scrollView.frame.width / 2)) / currentWidth) - (scrollView.frame.width / 2), 0)
  }
  
  override func canBecomeFirstResponder() -> Bool {
    return true
  }
  
  override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
    if (motion == UIEventSubtype.MotionShake) {
      invertColor()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    scrollView.delegate = self
    
    self.view.backgroundColor = UIColor.blackColor()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // Animation properties.
  
  var marqueeOffset: CGFloat = 0
  var currentMarqueeAnimationDuration: NSTimeInterval = 45
  let defaultMarqueeAnimationDuration: NSTimeInterval = 45
  let maxMarqueeAnimationDuration:     NSTimeInterval = 4000

  // Time-based animation.
  
  var timeNow:   NSTimeInterval = NSDate().timeIntervalSince1970
  var timeDelta: NSTimeInterval = NSDate().timeIntervalSince1970
  var timeThen:  NSTimeInterval = 0


    var cadl_timer: CADisplayLink;
    var cadl_lastTimestamp: NSTimeInterval;
  
  private func setDelta() {
    timeNow   = NSDate().timeIntervalSince1970
    timeDelta = timeNow - timeThen
    timeThen  = timeNow
  }
  
  private func onFrame() {
    setDelta()
  }
  
  var touchFactor:CGFloat = 3000
  
  private func updateAnimation() {
    let marqueeWidth: CGFloat = whiteTextContainer.frame.width / 3
    
    if (timeDirection > 0 && currentMarqueeAnimationDuration > NSTimeInterval(CGFloat(defaultMarqueeAnimationDuration) * lastScale)) {
      let result =  NSTimeInterval( (marqueeWidth * CGFloat(currentMarqueeAnimationDuration)) / (marqueeWidth + (CGFloat(timeDelta) * 15 * CGFloat(currentMarqueeAnimationDuration))))
      currentMarqueeAnimationDuration = max(result, NSTimeInterval(CGFloat(defaultMarqueeAnimationDuration) * lastScale))
    }
      
    else
      
    if (timeDirection < 0 && currentMarqueeAnimationDuration < NSTimeInterval(CGFloat(maxMarqueeAnimationDuration) * lastScale)) {
      let result = NSTimeInterval( (marqueeWidth * CGFloat(currentMarqueeAnimationDuration)) / (marqueeWidth - (CGFloat(timeDelta) * touchFactor * CGFloat(currentMarqueeAnimationDuration))))
      currentMarqueeAnimationDuration = min(abs(result), NSTimeInterval(CGFloat(maxMarqueeAnimationDuration) * lastScale))
    }

    marqueeOffset += CGFloat(timeDelta) / CGFloat(currentMarqueeAnimationDuration) * marqueeWidth
    scrollView.contentOffset = CGPointMake(marqueeOffset, 0)
  }
  
  func animate() {
    timeThen = NSDate().timeIntervalSince1970

    timer = NSTimer.schedule(interval: 0.001) { timer in
      self.onFrame()
      self.updateAnimation()
    }
  }
  
  var timer: NSTimer?
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    // White text.
    
    whiteTextContainer = MarqueeContainer(frame: scrollView.frame, text: baseText, fontName: fontName, textColor: UIColor.whiteColor(), padding: 0)
   // whiteTextContainer.alpha = 0


    let label = UILabel.init();
    label.text = baseText
    label.textColor = UIColor.whiteColor()
    label.frame = CGRectMake(0, 0, 300, 200);

  //  self.scrollView .addSubview(label)
    self.scrollView.addSubview(whiteTextContainer)
    
//    // Black text.
//    
//    blackTextContainer = MarqueeContainer(frame: scrollView.frame, text: baseText, fontName: fontName, textColor: UIColor.blackColor(), padding: textPadding)
//    whiteTextContainer.alpha  = 0
//    blackTextContainer.hidden = true
//    self.scrollView.addSubview(blackTextContainer)
//    
//    // Setup scroll container.

    marqueeOffset = whiteTextContainer.texts[0].frame.width

    scrollView.contentSize   = CGSizeMake(whiteTextContainer.frame.width, whiteTextContainer.frame.height)
  //  scrollView.contentOffset = CGPointMake(0, 0)

    // Start animation.
    
    animate()
    
    // Fade In.
    
//    UIView.animateWithDuration(0.5) {
//      self.whiteTextContainer.alpha = 1.0
//    //  self.blackTextContainer.alpha = 1.0
//    }
  }
  
  func scrollViewDidScroll(scrollView: UIScrollView) {
    let marqueeWidth = whiteTextContainer.frame.width / 3
   
    marqueeOffset = scrollView.contentOffset.x
    
    if marqueeOffset < marqueeWidth {
      marqueeOffset = scrollView.contentOffset.x + marqueeWidth
      scrollView.contentOffset = CGPointMake(marqueeOffset, 0)
    } else if marqueeOffset > (marqueeWidth * 2) {
      marqueeOffset = scrollView.contentOffset.x - marqueeWidth
      scrollView.contentOffset = CGPointMake(marqueeOffset, 0)
    }
    
    if (scrollView.panGestureRecognizer.state == UIGestureRecognizerState.Began) ||
       (scrollView.panGestureRecognizer.state == UIGestureRecognizerState.Changed) {
      touchFactor = 15000
    } else {
      touchFactor = 3000
    }
  }
  
  func scrollViewWillBeginDragging(scrollView: UIScrollView) {
    // timer?.invalidate()
    // timer = nil
    timeDirection = -1
  }
  
  func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
    if velocity.x > 0 {
      scrollView.setContentOffset(scrollView.contentOffset, animated: true);
    }
  }
  
  func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    if velocity.x < 0 {
      currentMarqueeAnimationDuration = NSTimeInterval(CGFloat(maxMarqueeAnimationDuration) * lastScale)
      //animate()
    }
  }
  
  var velocity: CGPoint = CGPointZero
  
  func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    self.velocity = velocity
  
    if velocity.x == 0 {
      // currentMarqueeAnimationDuration = NSTimeInterval(CGFloat(maxMarqueeAnimationDuration) * lastScale)
      // animate()
    } else if velocity.x > 0 {
      let marqueeWidth: CGFloat = whiteTextContainer.frame.width / 3
      
      currentMarqueeAnimationDuration = NSTimeInterval(marqueeWidth / velocity.x) / 700
      // animate()
    }
    
    timeDirection = 1
  }
  
  var timeDirection = 1

  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    print("touchesBegan")
    timeDirection = -1
  }
  
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    print("touchesEnded")
    timeDirection = 1
  }
}

