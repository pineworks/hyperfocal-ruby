# coding: utf-8
$:.push "#{File.expand_path('..', __FILE__)}/lib"
#lib = File.expand_path('../lib', __FILE__)
#
require 'hyperfocal/version'

Gem::Specification.new do |spec|
  spec.name          = "hyperfocal"
  spec.version       = Hyperfocal::VERSION
  spec.authors       = ["Pineworks Inc."]
  spec.email         = ["support@pineworks.io"]

  spec.summary       = "An event reporting app for Ruby"
  spec.homepage      = "http://hyperfocal.io"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  files  = `git ls-files`.split("\n") rescue []
  files &= (
    Dir['lib/**/*.{rb}'] +
    Dir['*.md']
  )

  spec.files         = files

#  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
#    f.match(%r{^(test|spec|features)/})
#  end

  spec.executables   = %w[hyperfocal]
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "typhoeus"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
