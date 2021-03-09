Pod::Spec.new do |spec|

  spec.name         = "DeviceHardware"
  spec.version      = "1.0.0"
  spec.summary      = "DeviceHardware is a package for getting iPhone, iPad and Mac model names and hardware information."
  spec.homepage     = "https://github.com/Shakshi3104/DeviceHardware"

  spec.license      = { :type => "MIT", :file => "LICENSE" }
  
  spec.author = "Shakshi3104"

  # spec.platform     = :ios
  # spec.platform     = :ios, "5.0"

  #  When using multiple platforms
  spec.ios.deployment_target = "12.0"
  spec.osx.deployment_target = "10.15"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"

  spec.source       = { :git => "https://github.com/Shakshi3104/DeviceHardware.git", :tag => "#{spec.version}" }

  spec.source_files  = "Sources/**/*.{swift}"
  
  spec.swift_version = "5.0"

end
