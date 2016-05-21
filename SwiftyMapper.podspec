Pod::Spec.new do |s|
  s.name             = "SwiftyMapper"
  s.version          = "0.1.3"
  s.summary          = "A better swift object mapper."
  s.description      = "A better swift object mapper."
  s.homepage         = "https://github.com/huajiahen/SwiftyMapper"
  s.license          = 'MIT'
  s.author           = { "huajiahen" => "forgottoon@gmail.com" }
  s.source           = { :git => "https://github.com/huajiahen/SwiftyMapper.git", :tag => "#{s.version}" }

  s.watchos.deployment_target = '2.0'
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.tvos.deployment_target = '9.0'
  
  s.requires_arc = true
  s.source_files = 'SwiftyMapper/*'
end
