# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'svg_spriter/version'

Gem::Specification.new do |spec|
  spec.name          = "svg_spriter"
  spec.version       = SvgSpriter::VERSION
  spec.authors       = ["Kyle Simmonds"]
  spec.email         = ["cinnamonkale@users.noreply.github.com"]

  spec.summary       = %q{Take a directory of SVG files, optimize them, and compile them into a single file using <symbol> elements.}
  spec.description   = %q{Based off svg-sprite for npm, this basic utility will allow you to use SVG sprites while only maintaining one instance of an SVG.}
  spec.homepage      = "https://github.com/cinnamonkale/svg-spriter"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"

  spec.add_dependency 'svg_optimizer'
end
