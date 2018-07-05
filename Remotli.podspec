Pod::Spec.new do |s|

  s.name         = "Remotli"
  s.version      = "1.0.0"
  s.summary      = "A networking framework designed to simplify the creation of model objects used in an application from json returned from a remote api."
  s.description  = "This framework is designed to work on the iOS platform and simplifies the process of sending network requests and parsing responses into local model objects."
  s.homepage     = "https://github.com/appteur/remotli.git"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = "Seth Arnott"
  s.platform     = :ios, "10.0"
  s.swift_version = '4.1'
#s.static_framework = true
  
  s.source 		 = { :git => 'https://github.com/appteur/remotli.git', :tag => "#{s.version}" }
  s.source_files = 'Remotli/*.{h,m,swift}', 'Remotli/**/*.{h,m,swift}'
  # s.resources = 'Remotli/*.{storyboard,xib,xcassets}'
  
end
  
