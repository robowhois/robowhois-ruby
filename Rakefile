require 'rubygems'
require 'bundler'

$:.unshift(File.dirname(__FILE__) + "/lib")
require 'robo_whois/version'


# Common package properties
PKG_NAME    = "robowhois"
PKG_VERSION = RoboWhois::VERSION


# Run test by default.
task :default => :spec
task :test => :spec


spec = Gem::Specification.new do |s|
  s.name              = PKG_NAME
  s.version           = PKG_VERSION
  s.summary           = "Ruby client for the RoboWhois API."
  s.description       = "Ruby client for the RoboWhois API."

  s.required_ruby_version = ">= 1.8.7"

  s.authors           = ["Simone Carletti"]
  s.email             = ["weppos@weppos.net"]
  s.homepage          = "https://github.com/robowhois/robowhois-ruby"

  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables       = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths     = %w( lib )

  s.add_dependency "httparty", "~> 0.8.0"

  s.add_development_dependency "rake", "~> 0.9"
  s.add_development_dependency "yard"
end


require 'rubygems/package_task'

Gem::PackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "Build the gemspec file #{spec.name}.gemspec"
task :gemspec do
  file = File.dirname(__FILE__) + "/#{spec.name}.gemspec"
  File.open(file, "w") {|f| f << spec.to_ruby }
end

desc "Remove any temporary products, including gemspec"
task :clean => [:clobber] do
  rm "#{spec.name}.gemspec" if File.file?("#{spec.name}.gemspec")
end

desc "Remove any generated file"
task :clobber => [:clobber_package]

desc "Package the library and generates the gemspec"
task :package => [:gemspec]


require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |t|
  t.verbose = !!ENV["VERBOSE"]
end


require 'yard'
require 'yard/rake/yardoc_task'

YARD::Rake::YardocTask.new(:yardoc) do |y|
  y.options = ["--output-dir", "yardoc"]
end

namespace :yardoc do
  task :clobber do
    rm_r "yardoc" rescue nil
  end
end

task :clobber => "yardoc:clobber"


desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I lib -r robowhois.rb"
end
