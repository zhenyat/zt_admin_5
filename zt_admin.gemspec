# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zt_admin/version'

Gem::Specification.new do |spec|
  spec.name          = "zt_admin"
  spec.version       = ZtAdmin::VERSION
  spec.authors       = ["Zhenya Telyukov"]
  spec.email         = ["telyukov@gmail.com"]

  spec.summary       = %q{Admin BackEnd Generator}
  spec.description   = %q{Tool to generate admin controllers, helpers and views for a Model}
  spec.homepage      = "http://dummy.com"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "bin" #"exe"
  spec.executables   = ["zt_admin"] #spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "rake", "~> 13.0"
end
