require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name          = "react-native-ios-modal"
  s.version       = package["version"]
  s.summary       = package["description"]
  s.homepage      = package["homepage"]
  s.license       = package["license"]
  s.authors       = package["author"]

  s.platforms     = { :ios => "9.0" }
  s.source        = { :git => "https://github.com/dominicstop/react-native-ios-modal.git", :tag => "#{s.version}" }

  s.source_files  = "ios/**/*.{h,m,mm,swift}"
  s.swift_version = ['4.0', '4.2', '5.0']

  s.dependency "React"
end
