source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

workspace 'HackerNews'

xcodeproj 'HackerNews.xcodeproj'
xcodeproj 'Features/NetworkManager/NetworkManager.xcodeproj'

def di_pods
    pod 'Swinject' 
end

def app_pods
    pod 'R.swift'
    pod 'Kingfisher'
    pod "Skeleton"
    pod 'EmptyDataSet-Swift', '~> 5.0.0'
end

def analitics_pod
    pod 'Fabric'
    pod 'Crashlytics'
end

def other_pods
    pod 'SwiftLint'
    pod 'Sourcery'
end

def test_pods
    pod 'Nimble'
    pod 'Quick'
    pod 'iOSSnapshotTestCase'
end

def test_ui_pods
  pod 'iOSSnapshotTestCase'
end

target :HackerNews do
	xcodeproj 'HackerNews.xcodeproj'
    app_pods
    di_pods
    analitics_pod
    other_pods
end

target :HackerNewsTests do
	xcodeproj 'HackerNews.xcodeproj'
    test_pods
    di_pods
end

target :HackerNewsUITests do
  xcodeproj 'HackerNews.xcodeproj'
    test_ui_pods
end

target :NetworkManager do
    xcodeproj 'Features/NetworkManager/NetworkManager.xcodeproj'
end

target :NetworkManagerTests do
    xcodeproj 'Features/NetworkManager/NetworkManager.xcodeproj'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '5.0'
        end
    end
end
