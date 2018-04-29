project 'StarRating.xcodeproj'

# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'DemoApp' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  platform :ios, '9.0'
  use_frameworks!
  
  pod 'StarRating', :path=> '../StarRatingFramework/StarRating'
#pod 'StarRating', :path => '../StarRating'
#pod 'StarRating', :path => ‘../StarRatingFramework/StarRating’
#pod 'StarRating', :podspec => '../StarRatingFramework/StarRating'

  # Pods for DemoApp

  target 'DemoAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'DemoAppUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'StarRating' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
 
  # Pods for StarRating

  target 'StarRatingTests' do
    inherit! :search_paths
    # Pods for testing
  end

end


post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
	config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
        config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
        config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
        end
    end
end
