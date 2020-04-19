Pod::Spec.new do |s|
s.name             = "GDTextSlot"
s.version          = "1.0.7"
s.summary          = "A customizable control for code/text input. Easy setup with Storyboard and attributes inspector or Code."
s.homepage         = "https://github.com/saeid/GDTextSlot"
s.license          = 'MIT'
s.author           = { "Saeid Basirnia" => "basirnia@icloud.com" }
s.source           = { :git => "https://github.com/saeid/GDTextSlot.git", :tag => "1.0.7"}

s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.0' }
s.platform     = :ios
s.ios.deployment_target  = '9.0'
s.requires_arc = true
s.swift_version = '5.0'
s.source_files = '*.swift'
s.frameworks = 'UIKit'

end

