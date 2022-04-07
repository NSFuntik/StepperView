# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'QLOGA' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'GoogleMaps'
  pod 'GooglePlaces'
  pod 'BottomSheetSwiftUI', :git => 'https://bitbucket.org/qloga/bottomsheet/src/QLoGaMods/bottomsheet.git', :branch => 'QLoGaMods'
  pod 'CalendarKit', :git => 'https://bitbucket.org/qloga/calendarkit/src/QLoGaMods/CalendarKit.git', :branch => 'QLoGaMods'
  pod 'AnyFormatKitSwiftUI', '~> 0.5.3'
  # Pods for QLOGA

end
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
      config.build_settings["ONLY_ACTIVE_ARCH"] = "YES"

    end
  end
end
