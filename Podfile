platform :ios, '12.0'
use_frameworks!

workspace 'GetUpside-Challenge'

def app_dependencies
  pod 'ArcGIS-Runtime-SDK-iOS'#, '100.10'
  
  # Google Maps routines
  pod 'GoogleMaps'
  pod 'Google-Maps-iOS-Utils'

  #Realm DB
  pod 'Realm'
  pod 'RealmSwift'
end

def map_dependencies
  # Google Maps routines
  pod 'GoogleMaps'
  pod 'Google-Maps-iOS-Utils'
end

target 'GetUpside-Challenge-App' do
  project 'GetUpside-Challenge-App/GetUpside-Challenge-App.xcodeproj'
  app_dependencies
  map_dependencies
end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
      if config.name == 'Debug'
        config.build_settings['OTHER_SWIFT_FLAGS'] = ['$(inherited)', '-Onone']
        config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
      end
    end
  end
end
