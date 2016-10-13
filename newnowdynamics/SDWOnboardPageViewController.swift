//
//  SDWOnboardPageViewController.swift
//  newnowdynamics
//
//  Created by alex on 8/23/16.
//  Copyright © 2016 SDWR. All rights reserved.
//

import UIKit

class SDWOnboardPageViewController: UIPageViewController {

    var isIntroMode:Bool = true
    var logoImageView:UIImageView!
    var rotateLabel:UILabel!
    var rotateView:UIView!
    var pageControl:TAPageControl!
    let closeButton:UIButton = UIButton.init()
    var parentDelegate:SDWMainController?
    var canHideRotateView:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()


        let dotView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 6, height: 6))
        dotView.layer.cornerRadius = 3
        dotView.layer.masksToBounds = true
        dotView.layer.borderColor = UIColor.whiteColor().CGColor
        dotView.layer.borderWidth = 1
        dotView.backgroundColor = UIColor.blackColor()

        let dotViewCurrent:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 6, height: 6))
        dotViewCurrent.layer.cornerRadius = 3
        dotViewCurrent.layer.masksToBounds = true
        dotViewCurrent.layer.borderColor = UIColor.whiteColor().CGColor
        dotViewCurrent.layer.borderWidth = 1
        dotViewCurrent.backgroundColor = UIColor.whiteColor()



        UIGraphicsBeginImageContextWithOptions(dotView.bounds.size, true, 2.0)
        dotView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let dotViewImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()


        UIGraphicsBeginImageContextWithOptions(dotViewCurrent.bounds.size, true, 2.0)
        dotViewCurrent.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let dotViewCurrentImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()


        pageControl = TAPageControl.newAutoLayoutView()
        self.view.addSubview(pageControl)
        pageControl.autoSetDimensionsToSize(CGSize.init(width: 0, height: 20))
        pageControl.autoPinToBottomLayoutGuideOfViewController(self, withInset: 50)
        pageControl.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        pageControl.numberOfPages =  isIntroMode ? 5 : 4
        pageControl.currentPage = 0
        pageControl.dotSize = CGSize.init(width: 6, height: 6)
        pageControl.spacingBetweenDots = 20
        pageControl.currentDotImage = dotViewCurrentImage
        pageControl.dotImage = dotViewImage



        closeButton.configureForAutoLayout()
        self.view.addSubview(closeButton)
        closeButton.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 10)
        closeButton.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 10)
        closeButton.autoSetDimensionsToSize(CGSizeMake(44, 44))
        closeButton.setImage(UIImage(named: "close"), forState: UIControlState.Normal)
        closeButton.addTarget(self, action:#selector(SDWOnboardPageViewController.closeOnboard(_:)), forControlEvents: UIControlEvents.TouchUpInside)


        rotateView = UIView.newAutoLayoutView()
        rotateView.backgroundColor = UIColor.blackColor()
        self.view.addSubview(rotateView)
        rotateView.autoPinEdgesToSuperviewEdges()


        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        paragraphStyle.alignment = NSTextAlignment.Center




        let mutableAttributedString = NSMutableAttributedString(string:"Please rotate your device to landscape mode",
                                                                attributes: [
                                                                    NSParagraphStyleAttributeName: paragraphStyle,
                                                                    NSBaselineOffsetAttributeName: NSNumber(float: 0)
            ])



        mutableAttributedString.addAttribute(NSForegroundColorAttributeName, value:  UIColor.whiteColor(),range: NSMakeRange(0, mutableAttributedString.length))
        mutableAttributedString.addAttribute(NSFontAttributeName,
                                             value: UIFont(
                                                name: "Relative-Book",
                                                size: 16.0)!,
                                             range: NSMakeRange(0, mutableAttributedString.length))


        mutableAttributedString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, mutableAttributedString.length))



        rotateLabel = UILabel.init()
        rotateLabel.configureForAutoLayout()
        rotateLabel.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        rotateLabel.textColor = UIColor.whiteColor()
        rotateLabel.attributedText = mutableAttributedString
        rotateLabel.textAlignment = NSTextAlignment.Center
        rotateLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        rotateLabel.numberOfLines = 2
        rotateView.addSubview(rotateLabel)
        rotateLabel.autoCenterInSuperview()
        rotateLabel.autoSetDimension(ALDimension.Width, toSize:min(self.view.bounds.size.width,self.view.bounds.size.height)-100)
        rotateLabel.alpha = 0.0

        logoImageView = UIImageView(image: UIImage(named: "Initial"))
        logoImageView.configureForAutoLayout()
        self.view.addSubview(logoImageView)
        logoImageView.autoPinEdgesToSuperviewEdges()
        logoImageView.alpha = 0.0


        if (!isIntroMode) {
            self.rotateView.hidden = true
        }


    }

    override func viewDidAppear(animated: Bool) {


        if (!isIntroMode) {
            return
        }


        UIView.animateWithDuration(2.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {

            self.logoImageView.alpha = 1.0
//            rotateView.alpha = 0.0

            }, completion: {
                (value: Bool) in







                UIView.animateWithDuration(1.3, delay: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: {

                    self.logoImageView.alpha = 0.0
                    self.rotateLabel.alpha = 1.0

                    }, completion: {
                        (value: Bool) in

                        self.canHideRotateView = true
                        self.revealUI()
                        
                })


                
        })
    }


    func closeOnboard(gestureRecognizer: UIGestureRecognizer) {
        self.dismissViewControllerAnimated(true, completion: {

            self.parentDelegate?.didCloseOnboard()
        })
    }
    



    func revealUI() {

        if (canHideRotateView) {

            canHideRotateView = false
            UIView.animateWithDuration(0.4, delay: 2.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: {

                self.rotateLabel.alpha = 0.0

                //            rotateView.alpha = 0.0

                }, completion: {
                    (value: Bool) in







                    UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {


                        self.rotateView.alpha = 0.0
                        
                        }, completion: {
                            (value: Bool) in
                            

                    })
                    
                    
                    
            })

        }
    }


}
