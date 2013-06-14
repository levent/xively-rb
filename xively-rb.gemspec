# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "xively-rb/version"

Gem::Specification.new do |s|
  s.name        = "xively-rb"
  s.version     = Xively::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Paul Bellamy", "Levent Ali", "Sam Mulube"]
  s.email       = ["paul.a.bellamy@gmail.com", "lebreeze@gmail.com", "sam@pachube.com"]
  s.homepage    = "http://github.com/xively/xively-rb"
  s.summary     = "A library for communicating with the Xively REST API, parsing and rendering Xively feed formats"
  s.description = "A library for communicating with the Xively REST API, parsing and rendering Xively feed formats"
  s.license     = "BSD 3-Clause License"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency("multi_json", ">=1.3.6")
  s.add_dependency("yajl-ruby", ">=1.1.0")
  s.add_dependency("httparty", ">=0.10.0")

  s.extra_rdoc_files = ["README.md", "CHANGELOG.md", "LICENSE.md", "CONTRIBUTING.md"]
  s.rdoc_options << '--main' << 'README'
end

