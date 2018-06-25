# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{em-whois}
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mike Jarema"]
  s.date = %q{2018-06-25}
  s.description = %q{Asynchronous WHOIS queries via EventMachine (based on synchronous whois gem)}
  s.email = %q{mike@jarema.com}
  s.files = [
    "Gemfile",
    "README.md",
    "Rakefile",
    "VERSION.yml",
    "em-whois.gemspec",
    "examples",
    "lib",
    "spec",

    "VERSION.yml",
    "README.md",
    ".rspec",
    "Gemfile",
    "Rakefile",
    "examples/async_whois.rb",
    "examples/async_parallel_whois.rb",
    "examples/sync_whois.rb",
    "lib/em-whois.rb",
    "spec/em-whois_spec.rb",
    "spec/helper/all.rb",
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/mikejarema/em-whois}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{Query WHOIS servers using native EventMachine connection classes.}
  s.test_files = [
    "spec/em-whois_spec.rb",
    "spec/helper/all.rb",
  ]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0".freeze)

  s.add_runtime_dependency('em-synchrony')
  s.add_runtime_dependency('whois', '= 4.0.6')

  s.add_development_dependency('rake')
  s.add_development_dependency('rspec')
  s.add_development_dependency('whois-parser', '= 1.1.0')

end
