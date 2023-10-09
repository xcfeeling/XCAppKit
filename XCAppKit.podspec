#
# Be sure to run `pod lib lint XCAppKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XCAppKit'
  s.version          = '1.0.3'
  s.summary          = '公共基础库.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
      公共基础库.
                       DESC

  s.homepage         = 'https://github.com/xcfeeling/XCAppKit.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xucheng' => '836290600@qq.com' }
  s.source           = { :git => 'https://github.com/xcfeeling/XCAppKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'

  s.source_files = 'XCAppKit/Classes/**/*'
  
  # s.public_header_files = 'Pod/Classes/**/*.h'
#  s.static_framework = true
  
  s.pod_target_xcconfig = {
    'VALID_ARCHS' => 'x86_64 armv7 arm64',
    'DEFINES_MODULE' => 'YES',
    'ENABLE_BITCODE' => 'NO',
    'OTHER_LDFLAGS' => '$(inherited) -ObjC',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  }
  
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
  'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES'  }
  
  s.frameworks = 'UIKit'

  # Rx Extensions
  s.dependency 'RxSwift', '~> 6.5.0'
  s.dependency 'RxCocoa', '~> 6.5.0'
  s.dependency 'RxDataSources', '~> 5.0.0'
  s.dependency 'NSObject+Rx', '~> 5.2.2'
  
  # UI
  s.dependency 'SVProgressHUD', '~> 2.2.5'
  s.dependency 'SnapKit', '~> 5.6.0'
  s.dependency 'MJRefresh', '~> 3.7.5'
  s.dependency 'Kingfisher', '~> 6.3.1'
  
  s.dependency 'ReusableKit', '3.0.0'
  s.dependency 'HandyJSON', '~> 5.0.2'
  s.dependency 'LKDBHelper', '~> 2.6.0'
  s.dependency 'MMKV', '1.2.14'
  s.dependency 'CocoaLumberjack/Swift'
  
  # 关闭第三方警告
  s.xcconfig = { "CLANG_WARN_DOCUMENTATION_COMMENTS" => 'NO' }
end
