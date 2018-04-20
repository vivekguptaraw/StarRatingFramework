//
//  star.swift
//  StarRating
//
//  Created by Vivek Gupta on 12/03/18.
//  Copyright © 2018 Vivek Gupta. All rights reserved.
//

import UIKit

@IBDesignable class star: UIView {

    @IBOutlet var contentVw: UIView!
    var gradlayer : CAGradientLayer!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.customInitStar()
        addStars(yellowGrad: yellowGrad, whiteGrad: whiteGrad)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.customInitStar()
        addStars(yellowGrad: yellowGrad, whiteGrad: whiteGrad)
    }
    
    @IBInspectable var selectedColor: UIColor = UIColor.red {
        willSet
        {
                selectedColor = newValue
        }
        didSet {            
                self.checkExstingLayer()
        }
    }
    @IBInspectable var yellowGrad: Float = 0.5{
        willSet
        {
            yellowGrad = newValue
        }
        didSet {
            self.checkExstingLayer()
//            if let _ = self.contentVw{
//                if let layers = self.contentVw.layer.sublayers{
//                    if layers.count > 0{
//                        if let oldGradLayer = layers[0] as? CAGradientLayer{
//                            oldGradLayer.removeFromSuperlayer()
//                            addStars(yellowGrad: yellowGrad, whiteGrad: whiteGrad)
//                        }
//                    }
//                }
//            }
            
        }
    }
    @IBInspectable var whiteGrad: Float = 0.5{
        willSet
        {
            whiteGrad = newValue
        }
        didSet {
            
        }
    }
    
    func checkExstingLayer(){
        if self.contentVw != nil{
            if let layers = self.contentVw.layer.sublayers{
                if layers.count > 0{
                    if let oldGradLayer = layers[0] as? CAGradientLayer{
                        oldGradLayer.removeFromSuperlayer()
                        addStars(yellowGrad: yellowGrad, whiteGrad: whiteGrad)
                    }
                }
            }
        }
    }
    
    
    func addStars(yellowGrad: Float,whiteGrad: Float) {
        gradlayer = self.makeGradient(yellowGrad: yellowGrad, whiteGrad: whiteGrad)
        var xMultiple: CGFloat = 0
        var yMultiple: CGFloat = 0
        var contentViewPos = CGPoint.zero
        let starPath = UIBezierPath()
        let shapeLayer = CAShapeLayer()
        starPath.move(to: CGPoint(x: xMultiple + 20.25, y: yMultiple + 0.5))
        starPath.addLine(to: CGPoint(x: xMultiple + 27.57, y: yMultiple  + 10.66))
        starPath.addLine(to: CGPoint(x: xMultiple + 39.98, y: yMultiple  + 14.15))
        starPath.addLine(to: CGPoint(x: xMultiple + 32.09, y: yMultiple  + 23.91))
        starPath.addLine(to: CGPoint(x: xMultiple + 32.45, y: yMultiple  + 36.23))
        starPath.addLine(to: CGPoint(x: xMultiple + 20.25, y: yMultiple  + 32.1))
        starPath.addLine(to: CGPoint(x: xMultiple + 8.05, y: yMultiple + 36.23))
        starPath.addLine(to: CGPoint(x: xMultiple + 8.41, y: yMultiple + 23.91))
        starPath.addLine(to: CGPoint(x: xMultiple + 0.52, y: yMultiple + 14.15))
        starPath.addLine(to: CGPoint(x: xMultiple + 12.93, y: yMultiple + 10.66))
        starPath.close()
        shapeLayer.path = starPath.cgPath
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.0
        var frm = starPath.bounds
        frm.size = CGSize(width: frm.size.width, height: 45)
        gradlayer.frame = frm
        frm.origin = CGPoint(x: 0, y: 0)
        gradlayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradlayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        let shapeMask = CAShapeLayer()
        shapeMask.path = starPath.cgPath
        shapeMask.strokeColor = UIColor.orange.cgColor
        shapeMask.fillColor = UIColor.gray.cgColor
        shapeMask.position = frm.origin
        gradlayer.mask = shapeMask
        self.contentVw.layer.addSublayer(gradlayer)
        xMultiple += 60
        self.contentVw.backgroundColor = UIColor.lightGray
    }
    
    func makeGradient(yellowGrad: Float, whiteGrad: Float) -> CAGradientLayer{
        let yellowColor = self.selectedColor.cgColor
        let whiteColor = UIColor.white.cgColor
        
        let colors = [yellowColor, whiteColor]
        let yellowFloat: NSNumber = NSNumber.init(value: yellowGrad)
        let whiteFloat: NSNumber = NSNumber.init(value: whiteGrad)
        
        let locations = [yellowFloat, whiteFloat]
        let layer = CAGradientLayer()
        layer.colors = colors
        layer.locations = locations
        return layer;
    }
    
    func customInitStar(){
//        Bundle.main.loadNibNamed("star", owner: self, options: nil);
//        self.addSubview(contentVw)
//        self.contentVw.frame = self.bounds;
        if self.subviews.count == 0 {
            print("Loading Nib")
            //let bundle = Bundle(forClass: self.dynamicType)
            let bundle = Bundle(for: type(of: self))
            let nib = UINib(nibName: "star", bundle: bundle)
            contentVw = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
            contentVw.frame = bounds
            contentVw.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(contentVw)
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        customInitStar()
        addStars(yellowGrad: yellowGrad, whiteGrad: whiteGrad)
        contentVw.prepareForInterfaceBuilder()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        //self.selectedColor = UIColor.purple
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

}

extension UIView {
    /** Loads instance from nib with the same name. */
    func loadNib<T:UIView>() -> T {
        let bundle = Bundle(for: T.self)
        let nibName = T.description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: T.self, options: nil).first as! T
    }
}
