lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'dsp'


Gem::Specification.new do |spec|
  spec.name          = "dsp"
  spec.version       = DSP::VERSION
  spec.authors       = ["姚露"]
  spec.email         = ["y1150264176@163.com"]
  spec.summary       = %q{dsp}
  spec.description   = %q{dsp}
  spec.homepage      = ""
  spec.license       = "GNU"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'httparty' , '>= 0.13.7'
end
