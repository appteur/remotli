# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'
use_frameworks!

source 'https://github.com/CocoaPods/Specs.git'

def local_pods
    pod 'SDCoreUtilities', :path => '../SDCoreUtilities'
end


# Network Kit Framework dependencies
target 'Remotli' do
    
    local_pods
    
    target 'RemotliTests' do
        inherit! :search_paths
        
    end
end

# Example test harness app pod dependencies
target 'RemotliExample' do

    target 'RemotliExampleTests' do
	inherit! :search_paths
	# Pods for testing
    end

    target 'RemotliExampleUITests' do
	inherit! :search_paths
	# Pods for testing
    end

end

# this hook silences warnings from dependencies defined above
# when building this project.
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = 'YES'
        end
    end
end
