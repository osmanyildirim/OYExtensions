Pod::Spec.new do |s|
  s.name                      = "OYExtensions"
  s.version                   = "1.0.3"
  s.summary                   = "Some useful extension for Swift"

  s.homepage                  = "https://github.com/osmanyildirim/OYExtensions.git"
  s.license                   = { :type => "MIT", :file => "LICENSE" }
  s.author                    = { "osmanyildirim" => "github.com/osmanyildirim" }

  s.ios.deployment_target     = "11.0"
  s.swift_version             = "5.7"
  s.requires_arc              = true

  s.source                    = { git: "https://github.com/osmanyildirim/OYExtensions.git", :tag => s.version }
  s.source_files              = "Sources/**/*.*"
end