#
# Be sure to run `pod lib lint BASReport.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BASReport'
  s.version          = '0.1.0'
  s.summary          = 'BASReport. Specially designed framework for Uffizio Reports.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "This is BASReport Framework created by BADAL SHAH. This reports contain particular reportformat which is very useful to create particular type of layout or UI. If you want to extend the feature of add some functionalty fill free to contact me on Email - badalpub1991@gmail.com or MobileNumber - 7737765555  or skype - badal1111991."

  s.homepage         = 'https://github.com/badalpub1991/BASReport'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'BADAL SHAH' => 'badalpub1991@gmail.com' }
  s.source           = { :git => 'https://github.com/badalpub1991/BASReport.git', :tag => s.version.to_s }
  s.social_media_url = 'https://www.facebook.com/badal1991'

  s.ios.deployment_target = '10.0'
  s.swift_version = '4.2'

  s.source_files = 'Sources/BASCustomReport/**/*'
  s.exclude_files = "BASReport/**/*.plist"

   s.resource_bundles = {
     'BASReport' => ['Sources/BASCustomReport/Themes/*.png']
   }
   s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
