//
//  ViewController.swift
//  HpStarView
//
//  Created by 朴子hp on 2019/9/12.
//  Copyright © 2019 朴子hp. All rights reserved.
//

import UIKit

class ViewController: UIViewController,HpStarViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStarView()
        setUpStarView1()
    }

    //MARK: - 星级评分展示、需要把交互关闭
    func setUpStarView() -> Void {
        
        let starView = HpStarView.init(frame: CGRect(x: 100,y: 100,width: 150,height: 30), numberOfStars: 5, currentStarCount: 3.4)
        starView.isUserInteractionEnabled = false
        starView.integerStar    = false // 完整星星
        self.view.addSubview(starView)
    }
    
    //MARK: - 点击评价
    func setUpStarView1() -> Void {
        
        let starView = HpStarView.init(frame: CGRect(x: 100,y: 200,width: 150,height: 30), numberOfStars: 5, currentStarCount: 3)
        starView.isLightImage = "star_bright"
        starView.isNorImage = "star_dark"
        starView.delegate = self
        // starView.integerStar    = false // 完整星星
        self.view.addSubview(starView)
        
    }
    
    func starViewDidChange(view: HpStarView, newScore: Float) {
        print("记录滑动位置--\(newScore)")
    }
}

