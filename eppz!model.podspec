Pod::Spec.new do |s|
  s.name             = "eppz!model"
  s.version          = "0.5.1"
  s.summary          = "A model layer for the everydays. Extreme simplicity (while fully customizable)."
  s.homepage         = "https://github.com/eppz/eppz.model"
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  
  s.author           = { "Borbás Geri, eppz!" => "hello@eppz.eu" }
  s.source           = { :git => "https://github.com/eppz/eppz.model.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/_eppz'

  s.ios.deployment_target = '5.0'
  s.requires_arc = true

  s.source_files = 'eppz!model'
  s.public_header_files = 'eppz!model/public/*.h'
  s.frameworks = 'Foundation'
end