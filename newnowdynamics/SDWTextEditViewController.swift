//
//  SDWTextEditViewController.swift
//  newnowdynamics
//
//  Created by alex on 3/26/16.
//  Copyright © 2016 SDWR. All rights reserved.
//

import UIKit

class SDWTextEditViewController: UIViewController, SDWPageable {

    let index:NSInteger = 2
    var currentTextColor:UIColor = UIColor.whiteColor()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        if (currentTextColor == UIColor.blackColor()) {

            self.view.backgroundColor = UIColor.blackColor()
        } else {
            self.view.backgroundColor = UIColor.whiteColor()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func changeTextColor(color:UIColor) -> Void {

        currentTextColor = color
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
