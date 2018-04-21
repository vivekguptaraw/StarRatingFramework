//
//  StarMainControl.swift
//  StarRating
//
//  Created by Vivek Gupta on 16/03/18.
//  Copyright © 2018 Vivek Gupta. All rights reserved.
//

import UIKit

protocol StarMainControlDelegate {
    func buttonClicked(with tag: Int, buttonText: String?, ratePoints: Float?)
}


@IBDesignable
class StarMainControl: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var interactionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var interactionStackView: UIStackView!
    @IBOutlet weak var ratePoints: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starControl: StarRatingView!
    @IBOutlet weak var rateNowButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet var contentView: UIView!
    var actionsCreated: (() -> Void)?
    var starMainControlDelegate: StarMainControlDelegate?
    var finaRating: Float = 0.0
    @IBInspectable var titleText: String = ""{
        didSet{
            if self.titleLabel != nil{
                self.titleLabel.isHidden = false
                self.titleLabel.text = titleText
            }
        }
    }
    @IBInspectable var descriptionText: String = ""{
        didSet{
            if self.descriptionLabel != nil{
                self.descriptionLabel.isHidden = false
                self.descriptionLabel.text = descriptionText
            }
        }
    }
    @IBInspectable var cancelText: String = ""{
        didSet{
            if self.cancelButton != nil{
                self.cancelButton.setTitle(cancelText, for: .normal)
            }
        }
    }
    @IBInspectable var rateNowText: String = ""{
        didSet{
            if self.rateNowButton != nil{
                self.rateNowButton.setTitle(rateNowText, for: .normal)
            }
        }
    }
    @IBInspectable public var ratingInspectable: Float = 0.0{
        didSet{
            if self.ratePoints != nil{
                self.ratePoints.text = String(ratingInspectable)
                self.starControl.ratingWillBeSetFromOutSide = ratingInspectable
                self.finaRating = ratingInspectable
            }
        }
    }
    @IBInspectable public var selectedColor: UIColor = UIColor.yellow{
        didSet{
            if self.starControl != nil{
                self.starControl.selectedColor = selectedColor
            }
        }
    }
     var totalActions: Int = 2{
        didSet{
            if actions.count > 2{
                setActions(count: totalActions)
                
            }
        }
    }
    
     var actions: [String] = []{
        didSet{
            if actions.count > 2{
                totalActions = actions.count
            }            
        }
    }
    let alertController = UIAlertController(title: "Options", message: "", preferredStyle: .actionSheet)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.customInit()
        self.setData()
    }
    
    func setData(){
        //self.starControl.selectedColor = UIColor.red
        self.starControl.starRatingDelegate = self
        self.checkTitleAndDescription()
    }
    
    func checkTitleAndDescription(){
        //MARK: Remove labels if text not set at initialization
        if titleLabel.text!.isEmpty || titleLabel.text == ""{
            self.titleLabel.isHidden = true
        }else{
            self.titleLabel.text = titleText
        }
        
        if descriptionLabel.text!.isEmpty || descriptionLabel.text == ""{
            self.descriptionLabel.isHidden = true
        }else{
            self.descriptionLabel.text = descriptionText
        }
    }
    
    func setActions(count: Int){
        self.interactionStackView.removeArrangedSubview(rateNowButton)
        self.interactionStackView.removeArrangedSubview(cancelButton)
        self.interactionStackView.alignment = .fill
        self.interactionStackView.axis = .vertical
        interactionStackView.translatesAutoresizingMaskIntoConstraints = false
        self.rateNowButton.removeFromSuperview()
        self.cancelButton.removeFromSuperview()
        var index: Int = 0
        for text in actions{
            let button = UIButton(type: .custom)
            button.tag = index
            button.addTarget(self, action: #selector(btnTouch), for: UIControlEvents.touchUpInside)
            button.setTitleColor(UIColor.purple, for: .normal)
            button.setTitle(text, for: .normal)
            interactionStackView.addArrangedSubview(button)
            index += 1
        }
        self.interactionViewHeight.constant = CGFloat( 50 * actions.count)
    }
    
    @objc func btnTouch(_ sender: UIButton){
        self.starMainControlDelegate?.buttonClicked(with: sender.tag, buttonText: sender.titleLabel?.text, ratePoints: self.finaRating)
    }
    @IBAction func cancelClicked(_ sender: UIButton) {
        self.starMainControlDelegate?.buttonClicked(with: sender.tag, buttonText: sender.titleLabel?.text, ratePoints: self.finaRating)
    }
    
    @IBAction func rateNowClicked(_ sender: UIButton) {
        self.starMainControlDelegate?.buttonClicked(with: sender.tag, buttonText: sender.titleLabel?.text, ratePoints: self.finaRating)
    }
    func customInit(){
//        Bundle.main.loadNibNamed("StarMainControl", owner: self, options: nil);
//        self.addSubview(contentView)
//        self.contentView.frame = self.bounds;
        if self.subviews.count == 0 {
            print("Loading Nib StarMainControl")
            //let bundle = Bundle(forClass: self.dynamicType)
            let bundle = Bundle(for: type(of: self))
            let nib = UINib(nibName: "StarMainControl", bundle: bundle)
            contentView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
            contentView.frame = bounds
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(contentView)
            rateNowButton.tag = 0
            cancelButton.tag = 1
        }
        
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        customInit()
        contentView.prepareForInterfaceBuilder()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        //customInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

extension StarMainControl: StarRatingDelegate{
    func setRating(with point: Any) {
        if let rate = point as? Float{
            self.ratePoints.text = "\(rate)"
            self.finaRating = rate
        }else{
            print(point)
        }
    }
    
    
}
