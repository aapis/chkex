# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "chkex/version"

Gem::Specification.new do |spec|
  spec.name          = "chkex"
  spec.version       = Chkex::VERSION
  spec.authors       = ["Ryan Priebe"]
  spec.email         = ["rpriebe@me.com"]

  spec.summary       = %q{Check expiration dates of a single domain or list of domains}
  spec.homepage      = "https://github.com/aapis/chkex"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "notifaction"
  spec.add_runtime_dependency "whois-parser"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"

end
