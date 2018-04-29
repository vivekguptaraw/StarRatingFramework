//
//  ViewController.swift
//  DemoApp
//
//  Created by Vivek Gupta on 18/04/18.
//  Copyright © 2018 Vivek Gupta. All rights reserved.
//

import UIKit
import StarRating

class ViewController: UIViewController{
    let str : StarRatingView = StarRatingView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        ssMain.starMainControlDelegate = self
    }
    @IBOutlet weak var ssMain: StarMainControl!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: StarMainControlDelegate{
    func buttonClicked(with tag: Int, buttonText: String?, ratePoints: Float?) {
        print(tag)
    }
    
    
}

