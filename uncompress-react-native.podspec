require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "uncompress-react-native"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => "10.0" }
  s.source       = { :git => "https://github.com/didisouzacosta/uncompress-react-native.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,mm,swift}"

  s.dependency "React-Core"
  s.dependency "SSZipArchive"
  s.dependency "UnrarKit", '~> 2.10-beta5'

  s.ios.deployment_target = '10.0'

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
end
