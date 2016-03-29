//
//  SDWTextViewController.swift
//  newnowdynamics
//
//  Created by alex on 3/26/16.
//  Copyright © 2016 SDWR. All rights reserved.
//

import UIKit


class SDWTextViewController: UIViewController, SDWPageable,UIScrollViewDelegate {

    var timeOffset:CFTimeInterval = 0
    var velocityX:CGFloat = 0
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
        self.mainTextLabel.type = .Continuous
        self.mainTextLabel.triggerScrollStart()
        self.mainTextLabel.animationDelay = 0.0
        self.mainTextLabel.speed = .Rate(10.0)
    }


    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)


    }
    @IBAction func didLongPress(sender: UILongPressGestureRecognizer) {

        let velocitySpeed:Float = self.mainTextLabel.sublabel.layer.speed/2


        self.mainTextLabel.sublabel.layer.timeOffset = self.mainTextLabel.sublabel.layer .convertTime(CACurrentMediaTime(), fromLayer: nil);
        self.mainTextLabel.sublabel.layer.beginTime = CACurrentMediaTime();
        self.mainTextLabel.sublabel.layer.speed = velocitySpeed

        self.mainTextLabel.maskLayer?.timeOffset = (self.mainTextLabel.maskLayer?.convertTime(CACurrentMediaTime(), fromLayer: nil))!;
        self.mainTextLabel.maskLayer?.beginTime = CACurrentMediaTime();
        self.mainTextLabel.maskLayer?.speed = velocitySpeed

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

        }
        else if sender.state == UIGestureRecognizerState.Changed {

            var pointSize:CGFloat  = (sender.velocity > 0.0 ? 1.0 : -1.0) + self.mainTextLabel.font.pointSize;
            pointSize = max(min(pointSize, 250), 20);
            self.mainTextLabel.font = UIFont.systemFontOfSize(pointSize)

        } else if (sender.state == UIGestureRecognizerState.Ended || sender.state == UIGestureRecognizerState.Cancelled || sender.state == UIGestureRecognizerState.Failed) {
        }


    }

    @IBAction func didPan(sender: UIPanGestureRecognizer) {



        if sender.state == UIGestureRecognizerState.Began {


        }
        else if sender.state == UIGestureRecognizerState.Changed {

            let velocity:CGPoint = sender.velocityInView(self.view!)
            velocityX = velocity.x

            if velocityX > 0 {

                self.mainTextLabel.type = .ContinuousReverse
            } else {
                self.mainTextLabel.type = .Continuous
            }

            let velocitySpeed:Float = Float(fabs(velocityX/10))
            print(velocitySpeed)

             self.mainTextLabel.sublabel.layer.timeOffset = self.mainTextLabel.sublabel.layer .convertTime(CACurrentMediaTime(), fromLayer: nil);
            self.mainTextLabel.sublabel.layer.beginTime = CACurrentMediaTime();
            self.mainTextLabel.sublabel.layer.speed = velocitySpeed

            self.mainTextLabel.maskLayer?.timeOffset = (self.mainTextLabel.maskLayer?.convertTime(CACurrentMediaTime(), fromLayer: nil))!;
            self.mainTextLabel.maskLayer?.beginTime = CACurrentMediaTime();
            self.mainTextLabel.maskLayer?.speed = velocitySpeed


        } else if (sender.state == UIGestureRecognizerState.Ended || sender.state == UIGestureRecognizerState.Cancelled || sender.state == UIGestureRecognizerState.Failed) {


        }
        
    }

}
