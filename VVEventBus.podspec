#
# Be sure to run `pod lib lint VVEventBus.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'VVEventBus'
  s.version          = '1.0.0'
  s.summary          = '事件总线'
  s.description      = <<-DESC
  事件总线，提供view和controller之间的双向通信，支持target-action和block方式，支持事件的分发，其中借鉴了RAC的元素和设计思想
                       DESC

  s.homepage         = 'https://github.com/zxf-sagittarius/VVEventBus'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zxf-sagittarius' => '2593147394@qq.com' }
  s.source           = { :git => 'https://github.com/zxf-sagittarius/VVEventBus.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.platform     = :ios, "8.0"
  s.source_files = 'VVEventBus/Classes/**/*.{h,m}'

end
