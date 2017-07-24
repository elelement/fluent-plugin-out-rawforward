$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name          = "fluent-plugin-out_rawforward"
  s.version       = `cat VERSION`
  s.authors       = ["cabreracanal"]
  s.email         = ["josele7@gmail.com"]
  s.description   = %q{Raw TCP forwarder output plugin for Fluentd}
  s.summary       = %q{Raw TCP forwarder output plugin for fluentd}
  s.homepage      = "https://github.com/elelement/fluent-plugin-out-rawforward"
  s.license       = 'None'

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_runtime_dependency "fluentd"

  s.add_development_dependency "rake"
  s.add_development_dependency "webmock"
end
