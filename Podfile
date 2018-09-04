source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

workspace 'HackerNews'

xcodeproj 'HackerNews.xcodeproj'
xcodeproj 'Features/NetworkManager/NetworkManager.xcodeproj'

def ui_pods
    pod 'MXSegmentedControl'
end

def net_pods
	pod 'Firebase', '2.5.0'
end

target :HackerNews do
	xcodeproj 'HackerNews.xcodeproj'
	ui_pods
    net_pods
end

target :NetworkManager do
    net_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.0'
        end
    end
end