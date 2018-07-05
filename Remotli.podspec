Pod::Spec.new do |s|

  s.name         = "Remotli"
  s.version      = "00.00.01"
  s.summary      = "A networking framework to simplify the creation of model objects used in an application from json returned from a remote api."
  s.description  = "This speeds the development process by reducing boilerplate network request and json parsing code."
  s.homepage     = "https://github.com/appteur/remotli.git"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = "Seth Arnott"
  s.platform     = :ios, "10.0"
  s.swift_version = '4.1'
#s.static_framework = true
  
  s.source 		 = { :git => 'https://github.com/appteur/remotli.git', :tag => "#{s.version}" }
  s.source_files = 'Remotli/*.{h,m,swift}', 'Remotli/**/*.{h,m,swift}'
  s.resources = 'Remotli/*.{storyboard,xib,xcassets}'
  
end
  
