platform :ios, '12.0'
use_frameworks!

workspace 'GetUpside-Challenge'

def pods
  pod 'ArcGIS-Runtime-SDK-iOS'
  
  # Google Maps routines
  pod 'GoogleMaps'

  #Realm DB
  pod 'RealmSwift', '4.4.1'
end

target 'GetUpside-Challenge-App' do
  project 'GetUpside-Challenge-App/GetUpside-Challenge-App.xcodeproj'
  pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.name == 'Debug'
        config.build_settings['OTHER_SWIFT_FLAGS'] = ['$(inherited)', '-Onone']
        config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
      end
    end
  end
end
