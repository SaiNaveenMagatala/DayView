#
# Be sure to run `pod lib lint DayView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DayView'
  s.version          = '0.1.1'
  s.summary          = 'A view which displays days and corresponding date in a collection view below it with infinite scroll.'
s.swift_version      = '4.2'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
* A view which displays days and corresponding date in a collection view below it with infinite scroll, paging is enabled and only fetches data as you scroll through.
* As the view loads the collection view fetches three weeks current week, previous week and the next week
and fetches later weeks as we scroll through.
* Initially the collection view scrolls to the current week and highlights current day.
                       DESC

  s.homepage         = 'https://github.com/SaiNaveenMagatala/DayView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'NaveenMagatala' => 'naveenmagatala@gmail.com' }
  s.source           = { :git => 'https://github.com/SaiNaveenMagatala/DayView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'DayView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'DayView' => ['DayView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
