require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name        = "google_geocoding"
    gem.summary     = %Q{Google's geocoding library}
    gem.description = %Q{GoogleGeocoding is a small library for performing geocoding using the Google's HTTP geocoding API}
    gem.email       = "divoxx@gmail.com"
    gem.homepage    = "http://github.com/divoxx/google_geocoding"
    gem.authors     = ["Rodrigo Kochenburger"]
    gem.add_dependency "json", ">= 1.2.0"
    gem.add_dependency "patron", ">= 0.4.5"
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_development_dependency "yard",  ">= 0.5.3"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
