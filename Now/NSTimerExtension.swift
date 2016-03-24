import Foundation

extension NSTimer {
  class func schedule(delay aDelay: NSTimeInterval, handler: NSTimer! -> Void) -> NSTimer {
    let fireDate = aDelay + CFAbsoluteTimeGetCurrent()
    let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, 0, 0, 0, handler)
    CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, kCFRunLoopCommonModes)
    return timer
  }
  
  class func schedule(interval aInterval: NSTimeInterval, handler: NSTimer! -> Void) -> NSTimer {
    let fireDate = aInterval + CFAbsoluteTimeGetCurrent()
    let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, aInterval, 0, 0, handler)
    CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, kCFRunLoopCommonModes)
    return timer
  }
}