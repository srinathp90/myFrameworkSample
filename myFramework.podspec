#
# Be sure to run `pod lib lint myFrameworkSample.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'myFramework'
  s.version          = '0.1.0'
  s.summary          = 'kickstarting ios myFramework'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/srinathp90/myFrameworkSample'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'srinath@codecraft.co.in' => 'srinath@codecraft.co.in' }
  s.source           = { :git => 'https://github.com/srinathp90/myFrameworkSample.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ShReeNATHP'

  s.ios.deployment_target = '9.0'

  s.source_files = 'myFrameworkSample/Classes/**/*'
  
  # s.resource_bundles = {
  #   'myFrameworkSample' => ['myFrameworkSample/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Alamofire', '= 4.4.0'
  s.dependency 'ObjectMapper', '= 2.2.5'
  s.dependency 'AlamofireObjectMapper', '= 4.1.0'
  s.dependency 'AlamofireImage', '= 3.2.0'
  s.dependency 'XCGLogger', '= 4.0.0'
  s.dependency 'ReachabilitySwift', '= 3.0.0'
  s.dependency 'XMPPFramework', '~> 3.7.0'
end
