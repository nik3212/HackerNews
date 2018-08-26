source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

workspace 'HackerNews'

xcodeproj 'HackerNews.xcodeproj'

def ui_pods
    pod 'MXSegmentedControl'
end

target :HackerNews do
	xcodeproj 'HackerNews.xcodeproj'
	ui_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.0'
        end
    end
end