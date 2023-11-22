#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint iz_scan.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'iz_scan'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter project.'
  s.description      = <<-DESC
A new Flutter project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'IZSolve' => 'izsolve.services@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.resources = ['Assets/**/*']
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'
  s.dependency 'CardScan'
  s.resource_bundles = {
  'IzScanPlugin' => ['Assets/**/*']
}

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
