//
//  SDWOnboardPageViewController.swift
//  newnowdynamics
//
//  Created by alex on 8/23/16.
//  Copyright © 2016 SDWR. All rights reserved.
//

import UIKit

class SDWOnboardPageViewController: UIPageViewController {

    var pageControl:TAPageControl!
    let closeButton:UIButton = UIButton.init()
    var parentDelegate:SDWMainController?

    override func viewDidLoad() {
        super.viewDidLoad()

//        for gr:UIGestureRecognizer in self.gestureRecognizers {
//
//            gr.delegate = self;
//        }

//        self.gestureRecognizers

//        for ( gR:UIGestureRecognizer,, in self.view.gestureRecognizers) {
//            gR.delegate = self;
//        }

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
        pageControl.autoSetDimensionsToSize(CGSize.init(width: 100, height: 20))
        pageControl.autoPinToBottomLayoutGuideOfViewController(self, withInset: 50)
        pageControl.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        pageControl.numberOfPages = 5
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

    }


    func closeOnboard(gestureRecognizer: UIGestureRecognizer) {
        self.dismissViewControllerAnimated(true, completion: {

            self.parentDelegate?.didCloseOnboard()
        })
    }
    


//    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
//        return true
//    }



}
