//
//  SDWOnboardContentViewController.swift
//  newnowdynamics
//
//  Created by alex on 8/23/16.
//  Copyright © 2016 SDWR. All rights reserved.
//

import UIKit

class SDWOnboardContentViewController: UIViewController,SDWPageable {

    @IBOutlet var y1: NSLayoutConstraint!
    @IBOutlet var x2: NSLayoutConstraint!
    @IBOutlet var mainGestureCircleDuplicate: UIView!
    @IBOutlet var mainCircleXCenter: NSLayoutConstraint!
    @IBOutlet var doubleCircle: UIView!
    @IBOutlet var mainGestureCircle: UIView!
    @IBOutlet var firstInfroText: UILabel!
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!


    var index:NSInteger = 0

    var mainImageFile:String!
    var titleString:String!
    var introTextString:String!

    let rightArrowImageView = UIImageView.init(image:UIImage.init(named: "arrow_right"))
    let leftArrowImageView = UIImageView.init(image:UIImage.init(named: "arrow_left"))
    let downArrowImageView = UIImageView.init(image:UIImage.init(named: "arrow_down"))

    func printFonts() {
        let fontFamilyNames = UIFont.familyNames()
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNamesForFamilyName(familyName )
            print("Font Names = [\(names)]")
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        self.alphaOutAllAnimatedViews()

        if (self.index != 0) {
            self.revealAnimatedViews()
        }


    }

    override func viewDidLoad() {
        super.viewDidLoad()


//        printFonts()


        self.setupAnimatedViews()




        if ((introTextString) != nil) {

            titleLabel.hidden = true
            mainImage.hidden = true
            firstInfroText.hidden = false



            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 8
            paragraphStyle.alignment = NSTextAlignment.Justified




            let mutableAttributedString = NSMutableAttributedString(string: introTextString,
                                                      attributes: [
                                                        NSParagraphStyleAttributeName: paragraphStyle,
                                                        NSBaselineOffsetAttributeName: NSNumber(float: 0)
                ])



            mutableAttributedString.addAttribute(NSForegroundColorAttributeName, value:  UIColor.whiteColor(),range: NSMakeRange(0, mutableAttributedString.length))
            mutableAttributedString.addAttribute(NSFontAttributeName,
                                         value: UIFont(
                                            name: "Relative-Book",
                                            size: 17.0)!,
                                         range: NSMakeRange(0, mutableAttributedString.length))


            mutableAttributedString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, mutableAttributedString.length))

            firstInfroText.attributedText = mutableAttributedString
            firstInfroText.numberOfLines = 0



        } else {


            titleLabel.hidden = false
            mainImage.hidden = false
            firstInfroText.hidden = true

            mainImage.image = UIImage.init(named: mainImageFile)
            self.view.backgroundColor = UIColor.blackColor()


            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 6
            paragraphStyle.alignment = NSTextAlignment.Center




            let mutableAttributedString = NSMutableAttributedString(string: titleString,
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
            
            titleLabel.attributedText = mutableAttributedString

            titleLabel.numberOfLines = 2


        }



    }


    func revealAnimatedViews() {


        if (self.index != 3) {
            mainGestureCircleDuplicate.hidden = true
        } else {
            mainGestureCircleDuplicate.hidden = false
        }


        if (self.index == 1) {
            UIView.animateWithDuration(1.3) {

                self.mainGestureCircle.alpha = 1.0
            }

            self.showSwipeLeftRight()
        }

        if (self.index == 2) {
            UIView.animateWithDuration(1.3) {

                self.mainGestureCircle.alpha = 1.0
            }
            self.showDoubleTap()
        }

        if (self.index == 3) {
            self.showPinchZoom()
        }

        if (self.index == 4) {
            self.showSwipeDown()
        }


    }


    func showSwipeDown() {

        y1.constant = -15

        downArrowImageView.configureForAutoLayout()
        downArrowImageView.autoSetDimensionsToSize(CGSizeMake(6,21.5))
        downArrowImageView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: mainGestureCircle, withOffset: 3)
        downArrowImageView.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)



        UIView.animateWithDuration(1.3, animations: {

            self.mainGestureCircle.alpha = 1.0
            self.downArrowImageView.alpha = 1.0

            }, completion: {
                (value: Bool) in



                UIView.animateWithDuration(1.5) {

            self.downArrowImageView.frame.origin.y += 3
                }
                
        })

    }

    func showSwipeLeftRight() {




        leftArrowImageView.configureForAutoLayout()
        leftArrowImageView.autoSetDimensionsToSize(CGSizeMake(21.5, 6))
        leftArrowImageView.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Left, ofView: mainGestureCircle, withOffset: -10)
        leftArrowImageView.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)

        rightArrowImageView.configureForAutoLayout()
        rightArrowImageView.autoSetDimensionsToSize(CGSizeMake(21.5, 6))
        rightArrowImageView.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: mainGestureCircle, withOffset: 10)
        rightArrowImageView.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)


        UIView.animateWithDuration(1.3, animations: {

            self.leftArrowImageView.alpha = 1.0
            self.rightArrowImageView.alpha = 1.0

            }, completion: {
                (value: Bool) in



                UIView.animateWithDuration(1.5) {

                    self.leftArrowImageView.frame.origin.x -= 2
                    self.rightArrowImageView.frame.origin.x += 2
                }

        })




    }


    func showDoubleTap() {


        UIView.animateWithDuration(1.3, animations: {

                self.doubleCircle.alpha = 1.0

            }, completion: {
                (value: Bool) in



                UIView.animateWithDuration(1.5) {

                    self.doubleCircle.transform = CGAffineTransformMakeScale(1.1, 1.1)
                }
                
        })


    }

    func showPinchZoom() {


        leftArrowImageView.configureForAutoLayout()
        leftArrowImageView.autoSetDimensionsToSize(CGSizeMake(21.5, 6))
        leftArrowImageView.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: self.view, withOffset: 0)
        leftArrowImageView.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)

        rightArrowImageView.configureForAutoLayout()
        rightArrowImageView.autoSetDimensionsToSize(CGSizeMake(21.5, 6))
        rightArrowImageView.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: self.view, withOffset: 0)
        rightArrowImageView.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)


        self.mainCircleXCenter.constant = 35
        self.x2.constant = -35

        UIView.animateWithDuration(1.3, animations: {

            self.mainGestureCircle.alpha = 1.0
            self.mainGestureCircleDuplicate.alpha = 1.0
            self.leftArrowImageView.alpha = 1.0
            self.rightArrowImageView.alpha = 1.0

            }, completion: {
                (value: Bool) in



                UIView.animateWithDuration(1.5) {

                    self.leftArrowImageView.frame.origin.x -= 2
                    self.rightArrowImageView.frame.origin.x += 2
                }

        })


        
        
    }

    func alphaOutAllAnimatedViews() {
        mainGestureCircleDuplicate.alpha = 0.0;
        leftArrowImageView.alpha = 0.0
        rightArrowImageView.alpha = 0.0
        downArrowImageView.alpha = 0.0
        mainGestureCircle.alpha = 0.0
        doubleCircle.alpha = 0.0
        self.mainCircleXCenter.constant = 0
        y1.constant = 0
        self.doubleCircle.transform = CGAffineTransformMakeScale(1.0, 1.0)
        self.mainGestureCircle.layoutIfNeeded()
    }


    func setupAnimatedViews() {

        if (self.index == 0) {
            mainGestureCircle.hidden = true
        } else {
            mainGestureCircle.hidden = false

            self.view.addSubview(leftArrowImageView)
            self.view.addSubview(rightArrowImageView)
            self.view.addSubview(downArrowImageView)


        }



        if (self.index == 2) {
            doubleCircle.hidden = false
        } else {
            doubleCircle.hidden = true
        }




        mainGestureCircle.backgroundColor = UIColor.clearColor()
        mainGestureCircle.layer.borderWidth = 1
        mainGestureCircle.layer.cornerRadius = mainGestureCircle.bounds.size.width/2
        mainGestureCircle.layer.borderColor = UIColor.whiteColor().CGColor
        mainGestureCircle.layer.masksToBounds = true


        mainGestureCircleDuplicate.backgroundColor = UIColor.clearColor()
        mainGestureCircleDuplicate.layer.borderWidth = 1
        mainGestureCircleDuplicate.layer.cornerRadius = mainGestureCircle.bounds.size.width/2
        mainGestureCircleDuplicate.layer.borderColor = UIColor.whiteColor().CGColor
        mainGestureCircleDuplicate.layer.masksToBounds = true


        doubleCircle.backgroundColor = UIColor.clearColor()
        doubleCircle.layer.borderWidth = 1
        doubleCircle.layer.cornerRadius = doubleCircle.bounds.size.width/2
        doubleCircle.layer.borderColor = UIColor.whiteColor().CGColor
        doubleCircle.layer.masksToBounds = true

    }

}
