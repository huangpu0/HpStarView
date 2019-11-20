# HpStarView
星级评价，展示
参考OC版YYsatrView等其他
https://github.com/WallaceYou/YYStarView


1.只展示评分 （需要关闭控件的交互性）

let starView = HpStarView.init(frame: CGRect(x: 100,y: 100,width: 150,height: 30), numberOfStars: 5, currentStarCount: 3.4)

starView.isUserInteractionEnabled = false

starView.integerStar    = false // 完整星星

self.view.addSubview(starView)


2.点击星级评价 实现代理（HpStarViewDelegate ）根据业务需求做对应事件

let starView = HpStarView.init(frame: CGRect(x: 100,y: 200,width: 150,height: 30), numberOfStars: 5, currentStarCount: 5)

starView.delegate = self

// starView.integerStar    = false // 完整星星

self.view.addSubview(starView)
