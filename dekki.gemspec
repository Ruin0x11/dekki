# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dekki/version'

Gem::Specification.new do |spec|
  spec.name          = "dekki"
  spec.version       = Dekki::VERSION
  spec.authors       = ["Ian Pickering"]
  spec.email         = ["ipickering2@gmail.com"]

  spec.summary       = "Generates TSV based on Japanese word frequency"
  # spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ["dekki"]
  spec.require_paths = ["lib"]

  spec.add_dependency 've', '~>0.0.3'
  spec.add_dependency 'ruby-jdict', '~>0.0.6'
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
