#!/usr/bin/env ruby
require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "snippets_converter"
    gem.summary = "Convert TextMate Snippets Gedit, NetBeans and Ruble (Aptana Studio) Snippets."
    gem.description = "Transform TextMate Snippets into Gedit, NetBeans and Ruble (Aptana Studio) snippets"
    gem.email = "nowhereman@open_office"
    gem.homepage = "http://github.com/nowhereman/snippets-converter"
    gem.authors = ["Nowhere Man"]
    gem.add_dependency('activesupport', '< 3.0.0')
    # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = "0.1.0"
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "snippets_converter #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

