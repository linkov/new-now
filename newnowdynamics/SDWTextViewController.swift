//
//  SDWTextViewController.swift
//  newnowdynamics
//
//  Created by alex on 3/26/16.
//  Copyright © 2016 SDWR. All rights reserved.
//

import UIKit


class SDWTextViewController: UIViewController, SDWPageable,UIScrollViewDelegate {



    var lastTimeOffset: CFTimeInterval = 0


    var lastSpeedBeforeDirectionChange:Float = 0
    var pinchFontBeginSpeed:Float!
    var lastVelocitySpeed:Float = 0
    var velocityX:CGFloat = 0
    var panGestureBeganTime:NSTimeInterval = 0
    var previousScrollSpeed:CGFloat = 0
    let index:NSInteger = 1
    let baseText:String = " THIS VERY MOMENT HAS ALREADY BECOME THE PAST – "
    @IBOutlet var mainTextLabel: MarqueeLabel!

    override func viewDidLoad() {
        super.viewDidLoad()


        self.mainTextLabel.text = self.baseText
        self.mainTextLabel.type = .Continuous

        self.mainTextLabel.font = UIFont(name: self.mainTextLabel.font.fontName, size: 300)
        self.mainTextLabel.animationDelay = 0.0
        self.mainTextLabel.speed = .Rate(10.0)
        self.mainTextLabel.triggerScrollStart()
        self.mainTextLabel.sublabel.layer.timeOffset = self.mainTextLabel.sublabel.layer .convertTime(CACurrentMediaTime(), fromLayer: nil)
        self.mainTextLabel.maskLayer?.timeOffset = (self.mainTextLabel.maskLayer?.convertTime(CACurrentMediaTime(), fromLayer: nil))!;

        self.view.backgroundColor = UIColor.blackColor()
        self.mainTextLabel.textColor = UIColor.whiteColor()
        self.updateToSpeed(30,shouldRestart:  true)


    }


    @IBAction func didLongPress(sender: UILongPressGestureRecognizer) {

        let velocitySpeed:Float = self.mainTextLabel.sublabel.layer.speed/2
        self.updateToSpeed(velocitySpeed,shouldRestart:  true)

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

//            var pointSize:CGFloat  = (sender.velocity > 0.0 ? 10.0 : -10.0) + self.mainTextLabel.font.pointSize;
//            pointSize = max(min(pointSize, 200), 60);
//            //print(pointSize)
//            self.mainTextLabel.font = UIFont(name: (self.mainTextLabel.font?.fontName)!, size: pointSize)


            var scale:CGFloat = self.mainTextLabel.superview!.transform.a

            if (sender.velocity > 0.0) {

                scale += 0.02

            } else {
                scale -= 0.02
            }

           scale =  max(min(scale, 3), 1.0);


//            let newTransform:CGAffineTransform = CGAffineTransformMake(1.0, 0.0, scale, 1.0, 0.0, 0.0);

//           self.mainTextLabel.superview!.transform = CGAffineTransformScale(newTransform, scale, 1)
               self.mainTextLabel.superview!.transform = CGAffineTransformMakeScale(scale, 1)



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


//            print(self.mainTextLabel.sublabel.layer.timeOffset)

            let velocity:CGPoint = sender.velocityInView(self.view!)
            velocityX = velocity.x
            let velocitySpeed:Float = Float(fabs(velocityX/10))

            lastSpeedBeforeDirectionChange = velocitySpeed
//            var resultingSpeed:Float = 0.0

//            lastTimeOffset = self.mainTextLabel.sublabel.layer.timeOffset


            if velocityX > 0 {

                        self.mainTextLabel.type = .ContinuousReverse


  //              resultingSpeed = -velocitySpeed;


            } else {

                        self.mainTextLabel.type = .Continuous
    //            resultingSpeed = velocitySpeed;
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
