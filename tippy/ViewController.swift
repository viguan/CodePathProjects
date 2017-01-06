//
//  ViewController.swift
//  tippy
//
//  Created by Vicky Guan on 1/5/17.
//  Copyright © 2017 Vicky Guan. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var peopleControl: UISegmentedControl!
    @IBOutlet weak var splitbillLabel: UILabel!
    @IBOutlet weak var peopleLabel: UILabel!
    @IBOutlet weak var pluralLabel: UILabel!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(sender: AnyObject) {
        // Dismissing keyboard
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyMotionEffect(toView: backgroundImageView, magnitude: 10)
        applyMotionEffect(toView: logoImageView, magnitude: -20)
    }
    
    @IBAction func calculateTip(sender: AnyObject) {
        let tipPercentages = [0.15, 0.18, 0.20]
        let numberPeople = [1, 2, 3, 4, 5]
        
        // If contents are nil, return 0
        let bill = Double(billField.text!) ?? 0
        
        let peoplechosen = Double(numberPeople[peopleControl.selectedSegmentIndex])
        
        let splitbill = bill/Double(numberPeople[peopleControl.selectedSegmentIndex])
        
        let splittip = (bill * tipPercentages[tipControl.selectedSegmentIndex])/Double(numberPeople[peopleControl.selectedSegmentIndex])
        
        let total = (splitbill + splittip)
        
        if peoplechosen == 1 {
            pluralLabel.text = "person"
        } else {
            pluralLabel.text = "people"
        }
        
        tipLabel.text = String(format: "$%.2f", splittip)
        totalLabel.text = String(format: "$%.2f", total)
        splitbillLabel.text = String(format: "$%.2f", splitbill)
        peopleLabel.text = String(format: "%.0f", peoplechosen)
    }
    
    // Applying a tilting motion effect
    func applyMotionEffect (toView view:UIView, magnitude:Float) {
        let xMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = -magnitude
        xMotion.maximumRelativeValue = magnitude
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
        yMotion.minimumRelativeValue = -magnitude
        yMotion.maximumRelativeValue = magnitude
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [xMotion, yMotion]
        
        view.addMotionEffect(group)
        
    }
}

