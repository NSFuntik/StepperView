# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'QLOGA' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'GoogleMaps', '6.0.1'
  pod 'GooglePlaces'
  pod 'INSPhotoGallery'
  pod 'BottomSheetSwiftUI', :git => 'https://github.com/DM1TRYM/BottomSheet.git', :commit => 'c9e23ee4985221fe9dd84516b594b55afe03df44'
  pod 'CalendarKit', :git => 'https://github.com/DM1TRYM/CalendarKit.git', :commit => '817349f9c4e9370adba9a54a864664db4748cb60'

  # Pods for QLOGA

end
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
    end
  end
end
