#
# Be sure to run `pod lib lint StepperView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'StepperView'
  s.version          = '1.6.7'
  s.swift_version    = '5.5'
  s.summary          = 'SwiftUI iOS component for Step Indications.'
  s.description      = 'Stepper View Indication componet for SwiftUI'
  s.homepage         = 'https://bitbucket.org/qloga/StepperView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.source           = { :git => 'https://bitbucket.org/qloga/StepperView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/badrivm'
  s.ios.deployment_target = '15.0'
  s.watchos.deployment_target = '6.0'
  s.source_files     = 'Sources/**/*.swift'
end
