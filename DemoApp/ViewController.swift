//
//  ViewController.swift
//  DemoApp
//
//  Created by Vivek Gupta on 18/04/18.
//  Copyright © 2018 Vivek Gupta. All rights reserved.
//

import UIKit
import StarRatingDraggable

class ViewController: UIViewController{
    
    
    let str : StarRatingView = StarRatingView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        ssMain.starMainControlDelegate = self
        ssMain.rateNowButton.setTitleColor(UIColor.red, for: .normal)
        ssMain.star1.selectedColor = UIColor.orange
        str.frame = CGRect(x: 10, y: UIScreen.main.bounds.height - 60, width: UIScreen.main.bounds.width - 20, height: 50)
        self.view.addSubview(str)
        str.backgroundColor = UIColor.green
        str.selectedColor = UIColor.purple
        str.starRatingDelegate = self
        str.ratingWillBeSetFromOutSide = 3.2
    }
    @IBOutlet weak var ssMain: StarMainControl!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : StarRatingDelegate{
    func setRating(with point: Any) {
        print(point)
    }
    
    
}

extension ViewController: StarMainControlDelegate{
    func buttonClicked(with tag: Int, buttonText: String?, ratePoints: Float?) {
        print(tag)
    }
}

