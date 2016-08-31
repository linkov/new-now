//
//  ViewController.swift
//  newnowdynamics
//
//  Created by alex on 3/24/16.
//  Copyright © 2016 SDWR. All rights reserved.
//

import UIKit


class SDWMainController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var pageViewController:UIPageViewController!
    var onboardPageViewController:SDWOnboardPageViewController!

    var textViewController:SDWTextViewController!
    var aboutViewController:SDWAboutViewController!
    var textEditViewController:SDWTextEditViewController!
    var onboardingControllers:[UIViewController]!

    var pendingIndex:Int?
    var currentIndex:Int?


    override func viewDidLoad() {
        super.viewDidLoad()

        self.textEditViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SDWTextEditViewController") as! SDWTextEditViewController
        self.aboutViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SDWAboutViewController") as! SDWAboutViewController
        self.aboutViewController.delegate = self
        self.textViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SDWTextViewController") as! SDWTextViewController

        self.textViewController.delegate = self




        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SDWPageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self;
        self.pageViewController.setViewControllers([self.textViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);

        self.addChildViewController(self.pageViewController)
        self.view .addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)


        

        self.onboardPageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SDWOnboardPageViewController") as! SDWOnboardPageViewController
        self.onboardPageViewController.dataSource = self;
        self.onboardPageViewController.delegate = self;
        self.onboardPageViewController.parentDelegate = self

        let introOnboard:SDWOnboardContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SDWOnboardContentViewController") as! SDWOnboardContentViewController
        introOnboard.introTextString = "New Now is a simple tool to remind of one thing that never changes: the life is always happening in the moment of absolute presence – the now. The now is always here, always new and always precious as it is the only point out of time that exists and where we exist"
        introOnboard.index = 0

        let firstOnboard:SDWOnboardContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SDWOnboardContentViewController") as! SDWOnboardContentViewController
        firstOnboard.titleString = "Swipe left or right or long press\nto control the speed of text"
        firstOnboard.mainImageFile = "iphone6"
        firstOnboard.index = 1

        let secondOnboard:SDWOnboardContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SDWOnboardContentViewController") as! SDWOnboardContentViewController
        secondOnboard.titleString = "Double tap anywhere to invert the colors"
        secondOnboard.mainImageFile = "iphone6"
        secondOnboard.index = 2

        let thirdOnboard:SDWOnboardContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SDWOnboardContentViewController") as! SDWOnboardContentViewController
        thirdOnboard.titleString = "Pinch zoom to distort the text"
        thirdOnboard.mainImageFile = "iphone6"
        thirdOnboard.index = 3


        let forthOnboard:SDWOnboardContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SDWOnboardContentViewController") as! SDWOnboardContentViewController
        forthOnboard.titleString = "Swipe up or down for extras"
        forthOnboard.mainImageFile = "iphone6"
        forthOnboard.index = 4



        onboardingControllers = [introOnboard, firstOnboard,secondOnboard,thirdOnboard,forthOnboard ]

        self.onboardPageViewController.setViewControllers([introOnboard ], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)




    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        if ((NSUserDefaults.standardUserDefaults().boolForKey("shouldShowOnboarding")) == true || NSUserDefaults.standardUserDefaults().valueForKey("shouldShowOnboarding") == nil) {

            self.openOnboard()
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "shouldShowOnboarding")
        }

    }

    func openOnboard() {

        self.textViewController.mainTextLabel.alpha = 0.0
        self.presentViewController(self.onboardPageViewController, animated: true, completion: nil)
    }

    func didCloseOnboard() {
        UIView.animateWithDuration(0.5, animations: {
            self.textViewController.mainTextLabel.alpha = 1.0
        })



    }


    // MARK: UIPageViewControllerDataSource

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {

        var viewControllerAtIndex:UIViewController = UIViewController()

        let pagableViewController = viewController as! SDWPageable
        var index:NSInteger  = pagableViewController.index

        if index == 0 || index == NSNotFound {
            return nil
        }

        index -= 1;

        if (pageViewController.isKindOfClass(SDWOnboardPageViewController.classForCoder())) {

            viewControllerAtIndex = self.onboardViewControllerAtIndex(index)!

        } else {



            viewControllerAtIndex = self.viewControllerAtIndex(index)!
        }




        return viewControllerAtIndex
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {


        print(viewController)

        var viewControllerAtIndex:UIViewController = UIViewController()

        if (pageViewController.isKindOfClass(SDWOnboardPageViewController.classForCoder())) {

            let pagableViewController = viewController as! SDWPageable
            var index:NSInteger  = pagableViewController.index

            if index == NSNotFound {
                return nil
            }

            index += 1;

            if index == 5 {

                return nil
            }

            viewControllerAtIndex = self.onboardViewControllerAtIndex(index)!

        } else {

            let pagableViewController = viewController as! SDWPageable
            var index:NSInteger  = pagableViewController.index

            if index == NSNotFound {
                return nil
            }

            index += 1;

            if index == 2 {
                return nil
            }
            
            viewControllerAtIndex = self.viewControllerAtIndex(index)!
        }





        return viewControllerAtIndex
    }


    func onboardViewControllerAtIndex(index:NSInteger) -> UIViewController? {

        return onboardingControllers[index]
    }


    func viewControllerAtIndex(index:NSInteger) -> UIViewController? {

        if index == 0 {
            return self.aboutViewController

        } else if index == 1 {
            return self.textViewController
        } else {
            return nil
        }
    }




    // textViewController delegate callbacks

    func didChangeTextToColor(color: UIColor) -> Void {


        self.aboutViewController.changeTextColor(color)
//        self.textEditViewController.changeTextColor(color)


        if (color == UIColor.blackColor()) {

            self.view.backgroundColor = UIColor.whiteColor()
            self.pageViewController.view.backgroundColor = UIColor.whiteColor()
        } else {
            self.view.backgroundColor = UIColor.blackColor()
            self.pageViewController.view.backgroundColor = UIColor.blackColor()
        }




    }







    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        pendingIndex = onboardingControllers.indexOf(pendingViewControllers.first!)
    }

    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            currentIndex = pendingIndex
            if let index = currentIndex {
                self.onboardPageViewController.pageControl.currentPage = index
            }
        }
    }


}

