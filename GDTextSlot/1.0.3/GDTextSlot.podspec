Pod::Spec.new do |s|
s.name             = "GDTextSlot"
s.version          = "1.0.3"
s.summary          = "Simple component for code input!"
s.homepage         = "https://github.com/saeid/GDTextSlot"
s.license          = 'MIT'
s.author           = { "Saeid Basirnia" => "saeid.basirniaa@gmail.com" }
s.source           = { :git => "https://github.com/saeid/GDTextSlot.git", :tag => "1.0.3"}

s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
s.platform     = :ios
s.ios.deployment_target  = '9.0'
s.requires_arc = true
s.swift_version = '4.0'
s.source_files = '*.swift'
s.frameworks = 'UIKit'

end
