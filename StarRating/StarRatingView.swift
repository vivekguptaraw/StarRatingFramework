//
//  StarRatingView.swift
//  StarRating
//
//  Created by Vivek Gupta on 12/03/18.
//  Copyright © 2018 Vivek Gupta. All rights reserved.
//

import UIKit

enum DragDirection {
    case Up
    case Down
    case Right
    case Left
    case None
}

 public protocol StarRatingDelegate {
    func setRating(with point: Any)
}

@IBDesignable public class StarRatingView: UIView, UIGestureRecognizerDelegate {

    @IBOutlet var contentVw: UIView!
    @IBOutlet weak var star5: star!
    @IBOutlet weak var star4: star!
    @IBOutlet weak var star3: star!
    @IBOutlet weak var star2: star!
    @IBOutlet weak var star1: star!
    var panGesture: UIPanGestureRecognizer!
    var tapGesture: UITapGestureRecognizer!
    var doubleTap: UITapGestureRecognizer!
    var dragDirection: DragDirection = .None
    public var starRatingDelegate: StarRatingDelegate?
    @IBInspectable public var selectedColor: UIColor = UIColor.red{
        
        didSet{
            setUptSelectedColor()
        }
    }
    
   @IBInspectable public var ratingWillBeSetFromOutSide: Float = 2.0{
        didSet{
            self.setUptSelectedColor()
            
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.customInit()
        //self.selectedColor = UIColor.purple
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.customInit()
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(StarRatingView.handlePanGesture))
        panGesture.delegate = self
        self.contentVw.addGestureRecognizer(panGesture)
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(StarRatingView.handleTapGesture))
        tapGesture.delegate = self
        self.contentVw.addGestureRecognizer(tapGesture)
       
    }
    
    @objc func handleTapGesture(_ tapGesture: UITapGestureRecognizer){
         let locationInView: CGPoint = tapGesture.location(in: self)
        switch tapGesture.state{
        case .began:
            return
        case .changed:
            let ptIn = locationInView.x / (self.frame.width / 5)
            let floorPointToMin = floor(ptIn)
            let starNumber = floorPointToMin + 1
            self.fillFullStar(starNum: Float(starNumber))
            return
        case .cancelled:
            return
        case .ended:
            let ptIn = locationInView.x / (self.frame.width / 5)
            let floorPointToMin = floor(ptIn)
            let starNumber = floorPointToMin + 1
            self.fillFullStar(starNum: Float(starNumber))
            return
        default:
            break
        }
    }
    
    func fillFullStar(starNum: Float){
        var num: Float = starNum
        if starNum == 1{
            if self.star1.yellowGrad == 1.0{
                num = 0.0
                self.star1.yellowGrad = num
            }else{
                num = 1.0
                self.star1.yellowGrad = num
            }
            if self.star2.yellowGrad != 0.0 || self.star3.yellowGrad != 0.0 || self.star4.yellowGrad != 0.0 || self.star5.yellowGrad != 0.0{
                self.star1.yellowGrad = 1.0
                self.star2.yellowGrad = 0.0
                self.star3.yellowGrad = 0.0
                self.star4.yellowGrad = 0.0
                self.star5.yellowGrad = 0.0
                num = 1.0
            }
            self.star3.yellowGrad = 0.0
            self.star4.yellowGrad = 0.0
            self.star5.yellowGrad = 0.0
        } else if starNum == 2{
            self.star1.yellowGrad = 1.0
            self.star2.yellowGrad = 1.0
            self.star3.yellowGrad = 0.0
            self.star4.yellowGrad = 0.0
            self.star5.yellowGrad = 0.0
        } else if starNum == 3{
            self.star1.yellowGrad = 1.0
            self.star2.yellowGrad = 1.0
            self.star3.yellowGrad = 1.0
            self.star4.yellowGrad = 0.0
            self.star5.yellowGrad = 0.0
        } else if starNum == 4{
            self.star1.yellowGrad = 1.1
            self.star2.yellowGrad = 1.0
            self.star3.yellowGrad = 1.0
            self.star4.yellowGrad = 1.0
            self.star5.yellowGrad = 0.0
        } else if starNum == 5{
            self.star1.yellowGrad = 1.1
            self.star2.yellowGrad = 1.0
            self.star3.yellowGrad = 1.0
            self.star4.yellowGrad = 1.0
            self.star5.yellowGrad = 1.0
        }
        self.starRatingDelegate?.setRating(with: num)
    }
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let locationInView: CGPoint = panGesture.location(in: self)
        let  actualVelocity = gesture.velocity(in: self)
        
        switch gesture.state{
        case .began:
            dragDirection = self.checkPanDirection(velocity: actualVelocity)
            return
        case .changed:
            let ptIn = locationInView.x / (self.frame.width / 5)
            let floorPointToMin = floor(ptIn)
            let starNumber = floorPointToMin + 1
            self.setStarGradient(starNum: starNumber, loc: ptIn)
            return
        case .ended:
            return
        default:
            break
        }
    }
    
    func setStarGradientFromIBInspec(value: Float){
        var pt = value
        if value > 5.0{
            pt = 5.0
        }
        let starNum = floor(pt) + 1 > 5 ? 5 : floor(pt) + 1
        self.setStarGradient(starNum: CGFloat(starNum), loc: CGFloat(pt))
        
    }
    
    func setStarGradient(starNum: CGFloat, loc: CGFloat){
        var _loc = Float(loc)
        if starNum == 1{
            print("Star 1 \(_loc)")
            self.star1.yellowGrad = _loc < 0.0 ? 0 : _loc
            self.star2.yellowGrad = Float(0)
            self.star3.yellowGrad = Float(0)
            self.star4.yellowGrad = Float(0)
            self.star5.yellowGrad = Float(0)
        } else if starNum == 2{
            self.star1.yellowGrad = Float(1)
            self.star2.yellowGrad = Float(loc - floor(loc))
            self.star3.yellowGrad = Float(0)
            self.star4.yellowGrad = Float(0)
            self.star5.yellowGrad = Float(0)
        } else if starNum == 3{
            self.star1.yellowGrad = Float(1)
            self.star2.yellowGrad = Float(1)
            self.star3.yellowGrad = Float(loc - floor(loc))
            self.star4.yellowGrad = Float(0)
            self.star5.yellowGrad = Float(0)
        }else if starNum == 4{
            self.star1.yellowGrad = Float(1)
            self.star2.yellowGrad = Float(1)
            self.star3.yellowGrad = Float(1)
            self.star4.yellowGrad = Float(loc - floor(loc))
            self.star5.yellowGrad = Float(0)
        } else if starNum == 5{
            self.star1.yellowGrad = Float(1)
            self.star2.yellowGrad = Float(1)
            self.star3.yellowGrad = Float(1)
            self.star4.yellowGrad = Float(1)
            self.star5.yellowGrad = _loc >= 5.0 ? Float(1) : Float(loc - floor(loc))
             print("Star 5 \(_loc)")
        }
        if _loc > 5.0 {
            _loc = 5.0
        }else if _loc < 0.0 {
            _loc = 0
        }
        let r = String(format: "%.1f", _loc)
        
        self.starRatingDelegate?.setRating(with: Float(r) ?? Float(0))
    }//String(format: "%.1f", loc)
    
    func checkPanDirection(velocity: CGPoint) -> DragDirection{
        if fabs(velocity.x) > fabs(velocity.y){
            if fabs(velocity.x) > 0 {
                return .Right
            } else{
                return .Left
            }
        }else{
            if fabs(velocity.y) > 0 {
                return .Down
            } else{
                return .Up
            }
        }
    }
    
    func customInit(){
        if self.subviews.count == 0 {
            let bundle = Bundle(for: type(of: self))
            let nib = UINib(nibName: "StarRatingView", bundle: bundle)
            contentVw = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
            contentVw.frame = bounds
            contentVw.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(contentVw)
        }
        if self.contentVw != nil{
            panGesture = UIPanGestureRecognizer(target: self, action: #selector(StarRatingView.handlePanGesture))
            panGesture.delegate = self
            self.contentVw.addGestureRecognizer(panGesture)
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(StarRatingView.handleTapGesture))
            tapGesture.delegate = self
            self.contentVw.addGestureRecognizer(tapGesture)
        }
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        customInit()
        setUptSelectedColor()
        contentVw.prepareForInterfaceBuilder()
        
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        //self.selectedColor = UIColor.purple
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setFillStarAtLocation(index: Int, gradientValue: Float){
        
    }
    
    func setInitialGradient(val: Float){
        star1.yellowGrad = 0.0
        star2.yellowGrad = 0.0
        star3.yellowGrad = 0.0
        star4.yellowGrad = 0.0
        star5.yellowGrad = 0.0
    }
    
    func setUptSelectedColor(){
        if (star1) != nil{
            star1.selectedColor = selectedColor
            star2.selectedColor = selectedColor
            star3.selectedColor = selectedColor
            star4.selectedColor = selectedColor
            star5.selectedColor = selectedColor
            self.setStarGradientFromIBInspec(value: self.ratingWillBeSetFromOutSide)
        }
    }

}
