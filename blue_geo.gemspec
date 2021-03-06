# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "blue_geo/version"

Gem::Specification.new do |s|
  s.name        = "blue_geo"
  s.version     = BlueGeo::VERSION
  s.authors     = ["Arti Sinani"]
  s.email       = ["artisinani@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Converts easting and northing into latitude and longitude}
  s.description = %q{Converts easting and northing into latitude and longitude}

  s.rubyforge_project = "blue_geo"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
