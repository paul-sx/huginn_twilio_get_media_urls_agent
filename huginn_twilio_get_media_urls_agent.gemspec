# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "huginn_twilio_get_media_urls_agent"
  spec.version       = '0.1'
  spec.authors       = ["Paul"]
  spec.email         = ["git@paul.sx"]

  spec.summary       = %q{Huginn Agent to get Media URLS}
  spec.description   = %q{Huginn Agent to get Twilio Conversation Media URLs from an array of media sids.}

  spec.homepage      = "https://github.com/paul-sx/huginn_twilio_get_media_urls_agent"

  spec.license       = "MIT"


  spec.files         = Dir['LICENSE.txt', 'lib/**/*']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = Dir['spec/**/*.rb']
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency "huginn_agent", '~> 0.2'
  spec.add_runtime_dependency "faraday"
end