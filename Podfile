source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

workspace 'HackerNews'

xcodeproj 'HackerNews.xcodeproj'
xcodeproj 'Features/NetworkManager/NetworkManager.xcodeproj'

def net_pods
	pod 'Firebase', '2.5.0'
end

def other_pods
    pod 'SwiftLint'
end

target :HackerNews do
	xcodeproj 'HackerNews.xcodeproj'
    net_pods
    other_pods
end

target :NetworkManager do
    xcodeproj 'Features/NetworkManager/NetworkManager.xcodeproj'
    net_pods
end

target :NetworkManagerTests do
    xcodeproj 'Features/NetworkManager/NetworkManager.xcodeproj'
    net_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.0'
        end
    end
end
