//
//  SDWTextViewController.swift
//  newnowdynamics
//
//  Created by alex on 3/26/16.
//  Copyright © 2016 SDWR. All rights reserved.
//

import UIKit


class SDWTextViewController: UIViewController, SDWPageable,UIScrollViewDelegate {

    var pinchFontBeginSpeed:Float!
    var lastVelocitySpeed:Float = 0
    var velocityX:CGFloat = 0
    var panGestureBeganTime:NSTimeInterval = 0
    var previousScrollSpeed:CGFloat = 0
    let index:NSInteger = 1
    let baseText:String = " THIS VERY MOMENT HAS ALREADY BECOME THE PAST – "


    @IBOutlet var scrollingView: SDWScrollTextView!

    @IBOutlet var mainTextLabel: MarqueeLabel!


    override func awakeFromNib() {
        super.awakeFromNib()


    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let myMutableString:NSMutableAttributedString = NSMutableAttributedString(
            string: baseText,
            attributes: [NSFontAttributeName:UIFont(
                name: "Georgia",
                size: 12.0)!])


        //self.view
        self.scrollingView.setupWithAttributedText(myMutableString as NSAttributedString)

        self.mainTextLabel.text = self.baseText
        self.mainTextLabel.type = .Continuous

        self.mainTextLabel.font = UIFont(name: self.mainTextLabel.font.fontName, size: 500)
        self.mainTextLabel.animationDelay = 0.0
        self.mainTextLabel.speed = .Rate(10.0)
        self.mainTextLabel.triggerScrollStart()


    }




    @IBAction func didLongPress(sender: UILongPressGestureRecognizer) {

        let velocitySpeed:Float = 0.0
        self.updateToSpeed(velocitySpeed,shouldRestart:  false)

    }

    @IBAction func didTap(sender: AnyObject) {

        if self.view.backgroundColor == UIColor.blackColor() {
            self.view.backgroundColor = UIColor.whiteColor()
            self.mainTextLabel.textColor = UIColor.blackColor()
        } else {
            self.view.backgroundColor = UIColor.blackColor()
            self.mainTextLabel.textColor = UIColor.whiteColor()
        }
    }

    @IBAction func didPinch(sender: UIPinchGestureRecognizer) {

        if sender.state == UIGestureRecognizerState.Began {

            self.pinchFontBeginSpeed = self.mainTextLabel.sublabel.layer.speed
            self.updateToSpeed(0,shouldRestart:  false)

        }
        else if sender.state == UIGestureRecognizerState.Changed {

            var pointSize:CGFloat  = (sender.velocity > 0.0 ? 10.0 : -10.0) + self.mainTextLabel.font.pointSize;
            pointSize = max(min(pointSize, 500), 60);
            //print(pointSize)
            self.mainTextLabel.font = UIFont(name: (self.mainTextLabel.font?.fontName)!, size: pointSize)


        } else if (sender.state == UIGestureRecognizerState.Ended || sender.state == UIGestureRecognizerState.Cancelled || sender.state == UIGestureRecognizerState.Failed) {

            //MarqueeLabel.controllerLabelsAnimate(self)
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
            if velocityX > 0 {

                self.scrollingView.scrollToLeft();
                self.scrollingView.label.layer.timeOffset = scrollingView.label.layer .convertTime(CACurrentMediaTime(), fromLayer: nil);
                self.scrollingView.label.layer.beginTime = CACurrentMediaTime();
                self.scrollingView.label.layer.speed = velocitySpeed




//                self.mainTextLabel.type = .ContinuousReverse
            } else {
               // self.mainTextLabel.type = .Continuous
            }

//            let velocitySpeed:Float = Float(fabs(velocityX/10))
//
//            self.updateToSpeed(velocitySpeed,shouldRestart:  true)



        } else if (sender.state == UIGestureRecognizerState.Ended || sender.state == UIGestureRecognizerState.Cancelled || sender.state == UIGestureRecognizerState.Failed) {


        }
        
    }

    private func restartMoving() -> Void {

        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(3 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {

            if self.lastVelocitySpeed < 0.8 {

                self.updateToSpeed(1,shouldRestart:  false)
            }


        }
        let delayTime1 = dispatch_time(DISPATCH_TIME_NOW, Int64(4 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime1, dispatch_get_main_queue()) {

            self.updateToSpeed(2,shouldRestart:  false)
            
        }

        let delayTime2 = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime2, dispatch_get_main_queue()) {
            
            self.updateToSpeed(3,shouldRestart:  false)
        }
    }


    private func updateToSpeed(newSpeed:Float, shouldRestart:Bool) -> Void {

        self.mainTextLabel.sublabel.layer.timeOffset = self.mainTextLabel.sublabel.layer .convertTime(CACurrentMediaTime(), fromLayer: nil);
        self.mainTextLabel.sublabel.layer.beginTime = CACurrentMediaTime();
        self.mainTextLabel.sublabel.layer.speed = newSpeed

        self.mainTextLabel.maskLayer?.timeOffset = (self.mainTextLabel.maskLayer?.convertTime(CACurrentMediaTime(), fromLayer: nil))!;
        self.mainTextLabel.maskLayer?.beginTime = CACurrentMediaTime();
        self.mainTextLabel.maskLayer?.speed = newSpeed
        self.lastVelocitySpeed = newSpeed



        if self.lastVelocitySpeed < 0.8 && shouldRestart {
           // self.restartMoving()
        }

    }

}
