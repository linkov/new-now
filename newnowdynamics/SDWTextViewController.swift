//
//  SDWTextViewController.swift
//  newnowdynamics
//
//  Created by alex on 3/26/16.
//  Copyright © 2016 SDWR. All rights reserved.
//

import UIKit

struct ScreenSize
{
    static let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS =  UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5 = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6 = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
}

class SDWTextViewController: UIViewController, SDWPageable,UIScrollViewDelegate {


    @IBOutlet var introImageView: UIImageView!

    var slowdownTimer:NSTimer?
    var lastTimeOffset: CFTimeInterval = 0
    var delegate:SDWMainController?

    var lastSpeedBeforeDirectionChange:Float = 0
    var pinchFontBeginSpeed:Float!
    var lastVelocitySpeed:Float = 0
    var velocityX:CGFloat = 0
    var panGestureBeganTime:NSTimeInterval = 0
    var previousScrollSpeed:CGFloat = 0
    let index:NSInteger = 1
    let baseText:String = " THIS NEW MOMENT HAS ALREADY BECOME THE PAST – "
    @IBOutlet var mainTextLabel: MarqueeLabel!



    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
//        self.updateToSpeed(0.0, shouldRestart: false)
//        self.mainTextLabel.pauseLabel()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        self.mainTextLabel.unpauseLabel()

         mainTextLabel.alpha = 0.0

        if (self.mainTextLabel.type == .ContinuousReverse) {
            self.mainTextLabel.type = .ContinuousReverse
        } else {
            self.mainTextLabel.type = .Continuous
        }





    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        UIView.animateWithDuration(1.3, delay: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: {

            self.mainTextLabel.alpha = 1.0

            }, completion: nil)

        UIView.animateWithDuration(0.6) {
            
            self.introImageView.alpha = 0.0
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.introImageView.alpha = 0.0


//        self.mainTextLabel.text = self.baseText

        let mutableAttributedString = NSMutableAttributedString(string: self.baseText,
                                                                attributes: [
                                                                    NSBaselineOffsetAttributeName: NSNumber(float: 0)
            ])

        mutableAttributedString.addAttribute(NSFontAttributeName,
                                             value: UIFont(
                                                name: "ProximaNovaCond-Semibold",
                                                size: 300.0)!,
                                             range: NSMakeRange(0, mutableAttributedString.length))

        mutableAttributedString.addAttribute(NSKernAttributeName, value: 10.0, range: NSMakeRange(0, mutableAttributedString.length))

        self.mainTextLabel.attributedText = mutableAttributedString


        self.mainTextLabel.type = .Continuous


        if (DeviceType.IS_IPHONE_6P) {
            self.mainTextLabel.font = UIFont(name: self.mainTextLabel.font.fontName, size: 200)

        } else {
            self.mainTextLabel.font = UIFont(name: self.mainTextLabel.font.fontName, size: 300)

        }
        self.mainTextLabel.animationDelay = 0.0
        self.mainTextLabel.speed = .Rate(10.0)
        self.mainTextLabel.triggerScrollStart()
        self.mainTextLabel.sublabel.layer.timeOffset = self.mainTextLabel.sublabel.layer .convertTime(CACurrentMediaTime(), fromLayer: nil)
        self.mainTextLabel.maskLayer?.timeOffset = (self.mainTextLabel.maskLayer?.convertTime(CACurrentMediaTime(), fromLayer: nil))!;

        self.view.backgroundColor = UIColor.blackColor()
        self.mainTextLabel.textColor = UIColor.whiteColor()
        self.updateToSpeed(30,shouldRestart:  true)


    }

    func startSlowdown() {


        if (self.mainTextLabel.sublabel.layer.speed > 1) {

//            print(self.mainTextLabel.sublabel.layer.speed)

            var velocitySpeed:Float = self.mainTextLabel.sublabel.layer.speed
            if (velocitySpeed > 150) {

                velocitySpeed -= 100
                
            } else if (velocitySpeed > 10) {
            velocitySpeed -= 10
            } else {

                velocitySpeed -= 1
            }

            self.updateToSpeed(velocitySpeed,shouldRestart:  true)
        }


    }


    @IBAction func didLongPress(sender: UILongPressGestureRecognizer) {

        if sender.state == UIGestureRecognizerState.Began {


            slowdownTimer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(SDWTextViewController.startSlowdown), userInfo: nil, repeats: true)

        }
        else if sender.state == UIGestureRecognizerState.Changed {




        } else if (sender.state == UIGestureRecognizerState.Ended || sender.state == UIGestureRecognizerState.Cancelled || sender.state == UIGestureRecognizerState.Failed) {

            slowdownTimer?.invalidate()
            slowdownTimer = nil

        }

    }

    @IBAction func didTap(sender: AnyObject) {

        if self.view.backgroundColor == UIColor.blackColor() {
            self.view.backgroundColor = UIColor.whiteColor()
            self.mainTextLabel.textColor = UIColor.blackColor()


        } else {
            self.view.backgroundColor = UIColor.blackColor()
            self.mainTextLabel.textColor = UIColor.whiteColor()
        }

        self.delegate!.didChangeTextToColor(self.mainTextLabel.textColor)
    }

    @IBAction func didPinch(sender: UIPinchGestureRecognizer) {

        if sender.state == UIGestureRecognizerState.Began {

            self.pinchFontBeginSpeed = self.mainTextLabel.sublabel.layer.speed
            self.updateToSpeed(0,shouldRestart:  false)

        }
        else if sender.state == UIGestureRecognizerState.Changed {

            var scale:CGFloat = self.mainTextLabel.superview!.transform.a

            if (sender.velocity > 0.0) {

                scale += 0.02

            } else {
                scale -= 0.02
            }

        scale =  max(min(scale, 3), 1.0);
        self.mainTextLabel.superview!.transform = CGAffineTransformMakeScale(scale, 1)


        } else if (sender.state == UIGestureRecognizerState.Ended || sender.state == UIGestureRecognizerState.Cancelled || sender.state == UIGestureRecognizerState.Failed) {

            self.updateToSpeed(self.pinchFontBeginSpeed,shouldRestart:  true)

        }


    }

    @IBAction func didPan(sender: UIPanGestureRecognizer) {


        if sender.state == UIGestureRecognizerState.Began {

            // do nothing



        }
        else if sender.state == UIGestureRecognizerState.Changed {


            let velocity:CGPoint = sender.velocityInView(self.view!)
            velocityX = velocity.x
            let velocitySpeed:Float = Float(fabs(velocityX/10))

            lastSpeedBeforeDirectionChange = velocitySpeed



            if velocityX > 0 {

                self.mainTextLabel.type = .ContinuousReverse

            } else {
                self.mainTextLabel.type = .Continuous

            }


            self.updateToSpeed(velocitySpeed,shouldRestart:  true)



        } else if (sender.state == UIGestureRecognizerState.Ended || sender.state == UIGestureRecognizerState.Cancelled || sender.state == UIGestureRecognizerState.Failed) {


        }

    }

    private func restartMoving() -> Void {


        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(3 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {

//            if self.lastVelocitySpeed < 0.1 {
//
//                self.updateToSpeed(3,shouldRestart:  false)
//            }




        }

    }


    private func updateToSpeed(newSpeed:Float, shouldRestart:Bool) -> Void {


        if (self.mainTextLabel.didChangeDirection) {


        } else {

        }

        self.mainTextLabel.sublabel.layer.timeOffset = self.mainTextLabel.sublabel.layer .convertTime(CACurrentMediaTime(), fromLayer: nil)

        self.mainTextLabel.sublabel.layer.beginTime = CACurrentMediaTime()
        self.mainTextLabel.sublabel.layer.speed = newSpeed

        self.mainTextLabel.maskLayer?.timeOffset = self.mainTextLabel.sublabel.layer .convertTime(CACurrentMediaTime(), fromLayer: nil)
        self.mainTextLabel.maskLayer?.beginTime = CACurrentMediaTime();
        self.mainTextLabel.maskLayer?.speed = newSpeed
        self.lastVelocitySpeed = newSpeed




        if shouldRestart {
            self.restartMoving()
        }
        
    }
    
}
