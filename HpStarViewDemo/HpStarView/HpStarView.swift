//
//  HpStartView.swift
//  Hp_SwiftBase
//
//  Created by 朴子hp on 2019/7/24.
//  Copyright © 2019 朴子hp. All rights reserved.
//

import UIKit

@objc public protocol HpStarViewDelegate {
    
    /// 星星百分比（得分值）发生变化的代理
    @objc optional func starViewDidChange(view: HpStarView, newScore: Float) -> ()
}

public class HpStarView: UIView {
    
    /// 代理
    public weak var delegate: HpStarViewDelegate?
    
    /// 整星，defualt is true
    public var integerStar:Bool = true {
        didSet{
            showStarRate()
        }
    }
    
    /// 滑动,defualt is false
    public var userPanEnabled:Bool = false{
        didSet{
            if userPanEnabled {
                let pan = UIPanGestureRecognizer(target: self,action: #selector(starViewPanGes(_:)))
                addGestureRecognizer(pan)
            }
        }
    }
    
    public var _followDuration:TimeInterval = 0.1//默认跟随时间为0.1秒
    public var  followDuration:TimeInterval{
        set{
            _followDuration = newValue
        }
        get{
            return _followDuration
        }
    }
    
    fileprivate var starForegroundView: UIView?
    public var _currentStarCount:Float = 0//当前的星星数量，defualt is 0
    public var  currentStarCount:Float{
        set{
            _currentStarCount = newValue
            showStarRate()
        }
        get{
            return _currentStarCount
        }
    }
    
    fileprivate var starBackgroundView:UIView?
    fileprivate var _numberOfStars:Int = 5//星星总数量，defualt is 5
    fileprivate var  numberOfStars:Int{
        set{
            _numberOfStars = newValue
        }
        get{
            return _numberOfStars
        }
    }
    
    
    // MARK: - 对象实例化
    override convenience public init(frame: CGRect) {
        self.init(frame: frame,numberOfStars:5,currentStarCount:0.0)
    }
    public init(frame: CGRect,numberOfStars:Int,currentStarCount:Float) {
        super.init(frame: frame)
        
        self.numberOfStars    = numberOfStars
        self.currentStarCount = currentStarCount
        clipsToBounds = true
        
        let tapGes = UITapGestureRecognizer(target: self,action: #selector(starViewTapGes(_:)))
        addGestureRecognizer(tapGes)
        
        starForegroundView = starViewWithImageName("star_nor@2x")
        addSubview(starForegroundView!)
        
        starBackgroundView = starViewWithImageName("star_pre@2x")
        addSubview(starBackgroundView!)
        
        showStarRate()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 绘制星星UI
    fileprivate func starViewWithImageName(_ imageName: String) -> UIView {
        
        let starView = UIView.init(frame: bounds)
        starView.clipsToBounds   = true
        
        //添加星星
        let width = frame.width / CGFloat(numberOfStars)
        
        for index in 0...numberOfStars {
            
            let imageView = UIImageView.init(frame: CGRect(x:CGFloat(index) * width,y: 0,width:width,height:bounds.size.height))
            let path = getBundle().path(forResource: imageName, ofType: "png")
            
            imageView.image = UIImage.init(contentsOfFile: path!)
            imageView.contentMode = .scaleAspectFit;
            starView.addSubview(imageView)
        }
        return starView
    }
    
    /// 显示评分
    fileprivate func showStarRate(){
        
        UIView.animate(withDuration: self.followDuration, animations: {
            
            if !self.integerStar{
                
                /// 支持非整星评分
                self.starBackgroundView?.frame = CGRect(x: 0,y: 0,width: self.bounds.width / CGFloat(self.numberOfStars) * CGFloat(self.currentStarCount),height: self.bounds.height)
                
            }else{
                
                /// 只支持整星评分
                self.starBackgroundView?.frame = CGRect(x: 0,y: 0,width: self.bounds.width / CGFloat(self.numberOfStars) * CGFloat(ceil(self.currentStarCount)) ,height: self.bounds.height)
            }
        })
    }
    
    //MARK: - 手势交互
    @objc func starViewPanGes(_ recognizer:UIPanGestureRecognizer) -> () {
        
        var OffX:CGFloat = 0
        if recognizer.state == .began{
            OffX = recognizer.location(in: self).x
        }else if recognizer.state == .changed{
            OffX += recognizer.location(in: self).x
        }else{
            return
        }
        currentStarCount = Float(OffX) / Float(bounds.width) * Float(numberOfStars)
        showStarRate()
        backSorce()
    }
    /// 点击评分
    @objc func starViewTapGes(_ recognizer:UITapGestureRecognizer) -> () {
        
        let OffX = recognizer.location(in: self).x
        currentStarCount = Float(OffX) / Float(bounds.width) * Float(numberOfStars)
        showStarRate()
        backSorce()
    }
    
    //MARK: - 协议回调/返回星星数
    fileprivate func backSorce(){
        
        if (delegate != nil) {
            var newScore:Float =  integerStar ? Float(ceil(self.currentStarCount)) :currentStarCount
            if  newScore > Float(numberOfStars){
                newScore = Float(numberOfStars)
            }else if newScore < 0{
                newScore = 0
            }
            //协议代理
            delegate?.starViewDidChange!(view: self, newScore: newScore)
        }
    }
    
}

// 获取对应的资源Bundle
extension HpStarView {
    
    func getBundle() -> Bundle {
        
        let budle = Bundle.init(for: HpStarView.self)
        let url:URL   = budle.url(forResource: "HpStar", withExtension: "bundle")!
        return Bundle.init(url: url)!
        
    }
    
}
