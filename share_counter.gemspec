# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'share_counter/version'

Gem::Specification.new do |spec|
  spec.name          = "share_counter"
  spec.version       = ShareCounter::VERSION
  spec.authors       = ["Davide Santangelo"]
  spec.email         = ["davide@chorally.com"]

  spec.summary       = %q{Check how many times a URL has been shared on social networks and aggregators}
  spec.description   = %q{This gem makes it super easy to check how many times a page/URL has been shared on social networks and aggregators.}
  spec.homepage      = "http://www.chorally.com"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"

  spec.add_dependency "rest-client"
  spec.add_dependency "json"
end
