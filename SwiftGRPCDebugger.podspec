#
# Be sure to run `pod lib lint SwiftGRPCDebugger.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftGRPCDebugger'
  s.version          = '0.1.3'
  s.summary          = 'A debugger for GRPC request using SwiftGRPC'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/tix-id/tix-swift-grpc-debugger'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Wais Al Korni' => 'wais.alkorni@tix.id' }
  s.source           = { :git => 'https://github.com/tix-id/tix-swift-grpc-debugger.git', :tag => s.version.to_s }

  s.swift_version = ['4.2', '5']
  s.ios.deployment_target = '10.0'
  s.requires_arc = true

  s.resource_bundles = {
    'SwiftGRPCDebugger' => ['SwiftGRPCDebugger/Classes/Debugger/*.xib']
  }

  s.info_plist = {
    'CFBundleIdentifier' => 'id.tix.SwiftGRPCDebugger'
  }

  s.source_files = 'SwiftGRPCDebugger/Classes/Debugger/*.swift', 'SwiftGRPCDebugger/Vendor/SwiftGRPC/**/*.swift', 'SwiftGRPCDebugger/Vendor/CgRPC/shim/*.[ch]'
  s.public_header_files = 'SwiftGRPCDebugger/Vendor/CgRPC/shim/cgrpc.h'

  s.dependency 'gRPC-Core', '~> 1.19.0'
  s.dependency 'SwiftProtobuf', '~> 1.5.0'
end
