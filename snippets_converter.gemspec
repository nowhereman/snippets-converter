# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{snippets_converter}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nowhere Man"]
  s.date = %q{2010-04-30}
  s.default_executable = %q{snippets_converter}
  s.description = %q{Quick and dirty code to transform TextMate Snippets into Gedit, NetBeans and Ruble (Aptana Studio) snippets}
  s.email = %q{nowhereman@open_office}
  s.executables = ["snippets_converter"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "bin/snippets_converter",
     "in/DummyFile",
     "lib/snippets_converter.rb",
     "lib/snippets_converter/editors/gedit.rb",
     "lib/snippets_converter/editors/netbeans.rb",
     "lib/snippets_converter/editors/ruble.rb",
     "out/DummyFile",
     "snippets_converter.gemspec",
     "test/test_helper.rb",
     "test/test_snippets_converter.rb"
  ]
  s.homepage = %q{http://github.com/nowhereman/snippets_converter}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Convert TextMate Snippets Gedit, NetBeans and Ruble (Aptana Studio) Snippets.}
  s.test_files = [
    "test/test_helper.rb",
     "test/test_snippets_converter.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

