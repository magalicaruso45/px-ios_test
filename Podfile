# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
source 'https://github.com/CocoaPods/Specs.git'
source 'git@github.com:mercadolibre/mobile-ios_specs.git'

target 'MercadoPagoSDKExampleSwift' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # //:git => 'git@github.com:mercadopago/px-ios.git', :branch => 'add_card_flow'
  # Pods for MercadoPagoSDKExampleSwift
  pod 'MLESCManager'
  pod 'PureLayout'
  pod 'MercadoPagoSDKV4/ESC', :path => '../px-ios'

  target 'MercadoPagoSDKExampleSwiftTests' do
    inherit! :search_paths
    pod 'MLReachability'
    # Pods for testing
  end

  target 'MercadoPagoSDKExampleSwiftUITests' do
    inherit! :search_paths
    pod 'MLReachability'
    pod 'MercadoPagoSDKV4/ESC', :path => '../px-ios'
    pod 'MLESCManager'
    pod 'PureLayout'
    pod 'FXBlurView'
    pod 'JRSwizzle'
    pod 'MLUI'
    # Pods for testing
  end

end
