//
//  SDWTextViewController.swift
//  newnowdynamics
//
//  Created by alex on 3/26/16.
//  Copyright © 2016 SDWR. All rights reserved.
//

import UIKit

class SDWTextViewController: UIViewController, SDWPageable,UIScrollViewDelegate {

    var panGestureBeganTime:NSTimeInterval = 0
    var previousScrollSpeed:CGFloat = 0
    let index:NSInteger = 1
    let baseText:String = " THIS VERY MOMENT HAS ALREADY BECOME THE PAST – "
    @IBOutlet var mainTextLabel: MarqueeLabel!
    var animator:UIDynamicAnimator!
    var linearVelocity:UIDynamicItemBehavior!
    var gravityBehaviour:UIGravityBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.mainTextLabel.text = self.baseText
        self.mainTextLabel.marqueeType = MarqueeType.MLContinuous
        self.mainTextLabel.triggerScrollStart()
        self.mainTextLabel.animationDelay = 0.0
        self.mainTextLabel.rate = 10
    }


    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)


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

           self.mainTextLabel.rate = 10
        }
        else if sender.state == UIGestureRecognizerState.Changed {

            var pointSize:CGFloat  = (sender.velocity > 0.0 ? 1.0 : -1.0) + self.mainTextLabel.font.pointSize;
            pointSize = max(min(pointSize, 250), 20);
            self.mainTextLabel.font = UIFont.systemFontOfSize(pointSize)

        } else if (sender.state == UIGestureRecognizerState.Ended || sender.state == UIGestureRecognizerState.Cancelled || sender.state == UIGestureRecognizerState.Failed) {

            self.mainTextLabel.rate = self.previousScrollSpeed
        }


    }

    @IBAction func didPan(sender: UIPanGestureRecognizer) {


        if sender.state == UIGestureRecognizerState.Began {

            // do nothing
        }
        else if sender.state == UIGestureRecognizerState.Changed {

            // do nothing

        } else if (sender.state == UIGestureRecognizerState.Ended || sender.state == UIGestureRecognizerState.Cancelled || sender.state == UIGestureRecognizerState.Failed) {

            if self .shouldPerformPan() == false {
                return
            }

            let velocity:CGPoint = sender.velocityInView(self.view!)
            let velocityX:CGFloat = velocity.x

            if velocityX > 0 {

                self.mainTextLabel.marqueeType = MarqueeType.MLContinuousReverse
            } else {
                self.mainTextLabel.marqueeType = MarqueeType.MLContinuous
            }

            self.mainTextLabel.rate = fabs(velocityX)
            self.previousScrollSpeed = self.mainTextLabel.rate
            self.panGestureBeganTime = NSDate().timeIntervalSince1970

        }
        
    }

    func shouldPerformPan() -> Bool {

        let delta:NSTimeInterval = NSDate().timeIntervalSince1970 - self.panGestureBeganTime

        if delta < 0.5 {

            return false
        }

        return true
    }
}
