# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flf_creator/version'

Gem::Specification.new do |spec|
  spec.name          = "flf_creator"
  spec.version       = FlfCreator::VERSION
  spec.authors       = ["Matthew Duffield"]
  spec.email         = ["mduffield@gmail.com"]
  spec.description   = %q{Helper for building fixed length files}
  spec.summary       = %q{Gem for fixed length file creation methods}
  spec.homepage      = "http://github.com/mduffield/flf_creator"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
