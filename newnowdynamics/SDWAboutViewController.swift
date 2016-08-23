//
//  SDWAboutViewController.swift
//  newnowdynamics
//
//  Created by alex on 3/26/16.
//  Copyright © 2016 SDWR. All rights reserved.
//

import UIKit

class SDWAboutViewController: UIViewController, SDWPageable {

    @IBOutlet var rightTextThree: UILabel!
    @IBOutlet var rightTextTwo: UILabel!
    @IBOutlet var rightTextOne: UILabel!
    @IBOutlet var leftText: UITextView!
    let index:NSInteger = 0

    var currentColor:UIColor = UIColor.whiteColor()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        self.rightTextOne.textColor = currentColor
        self.rightTextTwo.textColor = currentColor
        self.rightTextThree.textColor = currentColor
        self.leftText.textColor = currentColor

        if (currentColor == UIColor.blackColor()) {

            self.view.backgroundColor = UIColor.whiteColor()
        } else {
            self.view.backgroundColor = UIColor.blackColor()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func changeTextColor(color:UIColor) -> Void {

        currentColor = color

    }

    @IBAction func ShareDidTap(sender: AnyObject) {

        let textToShare = "New Now is Now"

        if let myWebsite = NSURL(string: "http://www.google.com/") {
            let objectsToShare = [textToShare, myWebsite]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

            activityVC.popoverPresentationController?.sourceView = self.view
            self.presentViewController(activityVC, animated: true, completion: nil)
        }
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
