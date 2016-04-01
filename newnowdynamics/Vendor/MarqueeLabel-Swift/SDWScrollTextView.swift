//
//  SDWScrollLabel.swift
//  newnowdynamics
//
//  Created by alex on 3/29/16.
//  Copyright © 2016 SDWR. All rights reserved.
//

import Foundation
import QuartzCore

public class SDWScrollTextView: UIView {

    var label:UILabel!
    var replicatorLayer:CAReplicatorLayer!
    var attributedText:NSAttributedString!

    //MARK: Interface

//    required public init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }


    public func setupWithAttributedText(attrString:NSAttributedString) -> Void {
        self.attributedText = attrString
        sdw_commonInit()
    }



    func sdw_commonInit() -> Void {

        self.replicatorLayer = CAReplicatorLayer()
        self.layer.addSublayer(self.replicatorLayer)
        self.replicatorLayer.frame = self.bounds

        self.label = UILabel(frame: self.bounds)
        self.addSubview(self.label)
        self.label.attributedText = self.attributedText

        let options: NSStringDrawingOptions = [.UsesLineFragmentOrigin, .UsesFontLeading]
        let textFrame:CGRect = self.attributedText.boundingRectWithSize(self.bounds.size, options: options, context: nil)

        print(textFrame)

    }


    func labelsForCurrentFrame() -> [UILabel]? {







//        let bar = CALayer()
//        bar.bounds = CGRect(x: 0.0, y: 0.0, width: 8.0, height: 40.0)
//        bar.position = CGPoint(x: 10.0, y: 75.0)
//        bar.cornerRadius = 2.0
//        bar.backgroundColor = UIColor.redColor().CGColor
//        
//        r.addSublayer(bar)

        return []
    }
}
