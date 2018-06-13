Pod::Spec.new do |s|
  s.name             = "UICollectionViewFlexLayout"
  s.version          = "1.1.0"
  s.summary          = "A drop-in replacement for UICollectionViewFlowLayout"
  s.homepage         = "https://github.com/devxoul/UICollectionViewFlexLayout"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "Suyeol Jeon" => "devxoul@gmail.com" }
  s.source           = { :git => "https://github.com/devxoul/UICollectionViewFlexLayout.git",
                         :tag => s.version.to_s }
  s.source_files = "Sources/**/*.{swift,h,m}"
  s.frameworks   = "UIKit"

  s.ios.deployment_target = "8.0"
end
