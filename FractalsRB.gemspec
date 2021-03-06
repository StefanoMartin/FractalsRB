# lib = File.expand_path("../lib", __FILE__)
# $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = "fractalsrb"
  s.version	    = "0.0.1"
  s.authors     = ["Stefano Martin"]
  s.email       = ["stefano.martin87@gmail.com"]
  s.homepage    = "https://github.com/StefanoMartin/FractalsRB"
  s.license     = "MIT"
  s.summary     = "A gem to create fractals"
  s.description = "A gem to create fractals"
  s.platform	   = Gem::Platform::RUBY
  s.require_paths = ["lib"]
  s.files         = ["lib/*", "FractalsRB.gemspec", "LICENSE.md", "README.md"].map {|f| `git ls-files #{f}`.split("\n") }.to_a.flatten
  s.add_runtime_dependency "chunky_png", ">= 1.3.11"
end
