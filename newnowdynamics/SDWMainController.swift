//
//  ViewController.swift
//  newnowdynamics
//
//  Created by alex on 3/24/16.
//  Copyright © 2016 SDWR. All rights reserved.
//

import UIKit


class SDWMainController: UIViewController, UIPageViewControllerDataSource {

    var pageViewController:UIPageViewController!
    var onboardPageViewController:UIPageViewController!

    var textViewController:SDWTextViewController!
    var aboutViewController:SDWAboutViewController!
    var textEditViewController:SDWTextEditViewController!


    override func viewDidLoad() {
        super.viewDidLoad()

        self.textEditViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SDWTextEditViewController") as! SDWTextEditViewController
        self.aboutViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SDWAboutViewController") as! SDWAboutViewController
        self.textViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SDWTextViewController") as! SDWTextViewController

        self.textViewController.delegate = self




        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SDWPageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self;
        self.pageViewController.setViewControllers([self.textViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);

        self.addChildViewController(self.pageViewController)
        self.view .addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)


        

        self.onboardPageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SDWOnboardPageViewController") as! UIPageViewController
        self.onboardPageViewController.dataSource = self;



    }


    // MARK: UIPageViewControllerDataSource

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {

        var viewControllerAtIndex:UIViewController = UIViewController()

        if (pageViewController.isKindOfClass(SDWOnboardPageViewController.classForCoder())) {

        } else {

            let pagableViewController = viewController as! SDWPageable
            var index:NSInteger  = pagableViewController.index

            if index == 0 || index == NSNotFound {
                return nil
            }

            index -= 1;

            viewControllerAtIndex = self.viewControllerAtIndex(index)!
        }




        return viewControllerAtIndex
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {


        var viewControllerAtIndex:UIViewController = UIViewController()

        if (pageViewController.isKindOfClass(SDWOnboardPageViewController.classForCoder())) {

        } else {

            let pagableViewController = viewController as! SDWPageable
            var index:NSInteger  = pagableViewController.index

            if index == NSNotFound {
                return nil
            }

            index += 1;

            if index == 3 {
                return nil
            }
            
            viewControllerAtIndex = self.viewControllerAtIndex(index)!
        }





        return viewControllerAtIndex
    }


    func onboardViewControllerAtIndex(index:NSInteger) -> UIViewController? {

        if index == 0 {
            return self.aboutViewController

        } else if index == 1 {
            return self.textViewController
        } else if index == 2 {
            return self.textEditViewController
        } else {
            return nil
        }
    }


    func viewControllerAtIndex(index:NSInteger) -> UIViewController? {

        if index == 0 {
            return self.aboutViewController

        } else if index == 1 {
            return self.textViewController
        } else if index == 2 {
            return self.textEditViewController
        } else {
            return nil
        }
    }




    // textViewController delegate callbacks

    func didChangeTextToColor(color: UIColor) -> Void {


        self.aboutViewController.changeTextColor(color)
        self.textEditViewController.changeTextColor(color)


        if (color == UIColor.blackColor()) {

            self.view.backgroundColor = UIColor.whiteColor()
            self.pageViewController.view.backgroundColor = UIColor.whiteColor()
        } else {
            self.view.backgroundColor = UIColor.blackColor()
            self.pageViewController.view.backgroundColor = UIColor.blackColor()
        }




    }

}

