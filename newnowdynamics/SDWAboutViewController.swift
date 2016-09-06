//
//  SDWAboutViewController.swift
//  newnowdynamics
//
//  Created by alex on 3/26/16.
//  Copyright © 2016 SDWR. All rights reserved.
//

import UIKit

class SDWAboutViewController: UIViewController, SDWPageable {

    var delegate:SDWMainController?

    @IBOutlet var openOnboardButton: UIButton!
    @IBOutlet var shareUnderlineView: UIView!
    @IBOutlet var openOnboardUnderlineView: UIView!
    @IBOutlet var kraftUnderlineView: UIView!
    @IBOutlet var letcusUnderlineView: UIView!
    @IBOutlet var alxUnderlineView: UIView!
    @IBOutlet var shareButton: UIButton!
    @IBOutlet var codedLabel: UILabel!
    @IBOutlet var designedLabel: UILabel!
    @IBOutlet var alxButton: UIButton!
    @IBOutlet var letcusButton: UIButton!
    @IBOutlet var kraftButton: UIButton!
    @IBOutlet var leftText: UITextView!
    let index:NSInteger = 0
    let leftTextString = "New Now is a simple tool to remind of one thing that never changes: the life is always happening in the moment of absolute presence – the now. The now is always here, always new and always precious as it is the only point out of time that exists and where we exist"
    var currentTextColor:UIColor = UIColor.whiteColor()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)



        if (currentTextColor == UIColor.blackColor()) {

            alxButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            letcusButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            kraftButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            shareButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            openOnboardButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)

            codedLabel.textColor = UIColor.whiteColor()
            designedLabel.textColor = UIColor.whiteColor()

            self.leftText.textColor = UIColor.whiteColor()

            kraftUnderlineView.backgroundColor = UIColor.whiteColor()
            letcusUnderlineView.backgroundColor = UIColor.whiteColor()
            alxUnderlineView.backgroundColor = UIColor.whiteColor()

            shareUnderlineView.backgroundColor = UIColor.whiteColor()
            openOnboardUnderlineView.backgroundColor =  UIColor.whiteColor()


            self.view.backgroundColor = UIColor.blackColor()


        } else {

            alxButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            letcusButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            kraftButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            openOnboardButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)


            kraftUnderlineView.backgroundColor = UIColor.blackColor()
            letcusUnderlineView.backgroundColor = UIColor.blackColor()
            alxUnderlineView.backgroundColor = UIColor.blackColor()
            shareUnderlineView.backgroundColor = UIColor.blackColor()
            openOnboardUnderlineView.backgroundColor =  UIColor.blackColor()


            shareButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)

            codedLabel.textColor = UIColor.blackColor()
            designedLabel.textColor = UIColor.blackColor()


            self.leftText.textColor = UIColor.blackColor()

            self.view.backgroundColor = UIColor.whiteColor()

        }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        paragraphStyle.alignment = NSTextAlignment.Justified




        let mutableAttributedString = NSMutableAttributedString(string: leftTextString,
                                                                attributes: [
                                                                    NSParagraphStyleAttributeName: paragraphStyle,
                                                                    NSBaselineOffsetAttributeName: NSNumber(float: 0)
            ])


        if (currentTextColor == UIColor.blackColor()) {
                    mutableAttributedString.addAttribute(NSForegroundColorAttributeName, value:  UIColor.whiteColor(),range: NSMakeRange(0, mutableAttributedString.length))
        } else {
                    mutableAttributedString.addAttribute(NSForegroundColorAttributeName, value:  UIColor.blackColor(),range: NSMakeRange(0, mutableAttributedString.length))
        }


        mutableAttributedString.addAttribute(NSFontAttributeName,
                                             value: UIFont(
                                                name: "Relative-Book",
                                                size: 16.0)!,
                                             range: NSMakeRange(0, mutableAttributedString.length))


        mutableAttributedString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, mutableAttributedString.length))

        leftText.attributedText = mutableAttributedString




    }


    func changeTextColor(color:UIColor) -> Void {
        currentTextColor = color
    }


    @IBAction func alxDidTap(sender: AnyObject) {

        let requestUrl = NSURL(string: "http://werk.studio")
        UIApplication.sharedApplication().openURL(requestUrl!)

    }


    @IBAction func letcusDidTap(sender: AnyObject) {

        let requestUrl = NSURL(string: "https://vimeo.com/letcius")
        UIApplication.sharedApplication().openURL(requestUrl!)

    }

    @IBAction func kraftDidTap(sender: AnyObject) {

        let requestUrl = NSURL(string: "http://egorkraft.co.uk/")
        UIApplication.sharedApplication().openURL(requestUrl!)
    }

    @IBAction func ShareDidTap(sender: AnyObject) {

        let textToShare = "App for the moment of absolute presence"

        if let myWebsite = NSURL(string: "https://itunes.apple.com/us/app/apple-store/id1150307790?mt=8") {
            let objectsToShare = [textToShare, myWebsite]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

            activityVC.popoverPresentationController?.sourceView = self.view
            self.presentViewController(activityVC, animated: true, completion: nil)
        }
    }

    @IBAction func openOnboardDidTap(sender: AnyObject) {
//
      self.delegate?.openOnboard()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
