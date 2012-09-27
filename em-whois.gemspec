# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{em-whois}
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mike Jarema"]
  s.date = %q{2012-09-27}
  s.description = %q{Asynchronous WHOIS queries via EventMachine (based on synchronous whois gem)}
  s.email = %q{mike@jarema.com}
  s.files = [
    "VERSION.yml",
    "README.md",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
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

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<em-synchrony>, [">= 0"])
      s.add_runtime_dependency(%q<whois>, ["= 2.7.0"])
    else
      s.add_dependency(%q<em-synchrony>, [">= 0"])
      s.add_dependency(%q<whois>, ["= 2.7.0"])
    end
  else
    s.add_dependency(%q<em-synchrony>, [">= 0"])
    s.add_dependency(%q<whois>, ["= 2.7.0"])
  end
end
