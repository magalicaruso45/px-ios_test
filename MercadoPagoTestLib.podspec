Pod::Spec.new do |s|
  s.name             = "MercadoPagoTestLib"
  s.version          = "0.0.2"
  s.summary          = "MercadoPago Test Library"
  s.homepage         = "https://www.mercadopago.com"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = "Mercado Pago"
  s.source           = { :git => "https://github.com/mercadopago/px-ios_test.git", :tag => s.version.to_s }

  s.platform     = :ios, '9.0'
  s.requires_arc = true
  s.source_files = ['MercadoPagoSDKExampleSwiftUITests/ScreenObject/*.swift','MercadoPagoSDKExampleSwiftUITests/ScreenObject/PXFlows/*.swift']
  s.dependency 'MercadoPagoSDK', '4.0.0.beta.23'


  s.swift_version = '4.0'
  s.frameworks = 'XCTest'

end
