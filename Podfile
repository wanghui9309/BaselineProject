platform :ios, '8.0'
inhibit_all_warnings!

target 'BaselineProject' do
  # use_frameworks!

  # Pods for BaselineProject
  pod 'AFNetworking'
  pod 'SDWebImage'
  pod 'MJRefresh'
  pod 'MJExtension'
  pod 'DZNEmptyDataSet'
  pod 'IQKeyboardManager'
  pod 'CocoaLumberjack'
  pod 'Reachability'
  pod 'TZImagePickerController'
  pod 'YYKit'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        if target.name == "Masonry"
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '8.0'
            end
        end
    end
end
