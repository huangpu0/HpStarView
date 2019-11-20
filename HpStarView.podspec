Pod::Spec.new do |spec|

spec.name         = "HpStarView"
spec.version      = "0.0.2"
spec.summary      = "HpStarView for iOS"
spec.description  = "A simple and easy to use and powerful star rating or display framework with cocoapod support."

spec.homepage     = "https://github.com/huangpu0/HpStarView.git"
spec.license      = "MIT"
spec.author       = { "huangpu0" => "huangpu0205@163.com" }

spec.source       = { :git => "https://github.com/huangpu0/HpStarView.git", :tag => "#{spec.version}" }
spec.source_files = "HpStarViewDemo/HpStarView/*.{swift}"

spec.ios.deployment_target = '8.0'
spec.swift_version = '5.0'
spec.frameworks    = 'UIKit'
spec.requires_arc  = true
spec.resource      = "HpStarViewDemo/HpStarView/HpStar.bundle"


 
end
