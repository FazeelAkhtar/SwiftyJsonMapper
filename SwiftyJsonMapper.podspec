Pod::Spec.new do |s|
  s.name                      = "SwiftyJsonMapper"
  s.version                   = "1.2.2"
  s.summary                   = "A JSON Object Mapping library for Swift"
  s.homepage                  = "https://github.com/fazilakhter/SwiftyJsonMapper"
  s.license                   = "MIT License"
  s.author                    = { "Fazeel Akhter" => "fazilakhter@hotmail.com" }
  s.ios.deployment_target     = "9.0"
  s.source                    = { :git => "https://github.com/fazilakhter/SwiftyJsonMapper.git",
                                  :tag => s.version.to_s }
  s.requires_arc              = true
  s.source_files              = "Sources/**/*.swift"
  s.module_name               = "SwiftyJsonMapper"
end
