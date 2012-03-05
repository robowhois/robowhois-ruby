# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "robowhois"
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Simone Carletti"]
  s.date = "2012-03-05"
  s.description = "Ruby client for the RoboWhois API."
  s.email = ["weppos@weppos.net"]
  s.files = [".gitignore", ".rspec", "CHANGELOG.md", "Gemfile", "Gemfile.lock", "LICENSE", "README.md", "Rakefile", "lib/robo_whois.rb", "lib/robo_whois/version.rb", "lib/robowhois.rb", "robowhois.gemspec", "spec/fixtures/account.dump", "spec/fixtures/account.json", "spec/fixtures/commands.sh", "spec/fixtures/whois.dump", "spec/fixtures/whois.txt", "spec/fixtures/whois/availability/available.dump", "spec/fixtures/whois/availability/available.json", "spec/fixtures/whois/availability/registered.dump", "spec/fixtures/whois/availability/registered.json", "spec/fixtures/whois/properties/available.dump", "spec/fixtures/whois/properties/available.json", "spec/fixtures/whois/properties/registered.dump", "spec/fixtures/whois/properties/registered.json", "spec/fixtures/whois_parts.dump", "spec/fixtures/whois_parts.json", "spec/fixtures/whois_record.dump", "spec/fixtures/whois_record.json", "spec/spec_helper.rb", "spec/support/fake_request_helpers.rb", "spec/support/helpers.rb", "spec/unit/robo_whois_spec.rb"]
  s.homepage = "https://github.com/robowhois/robowhois-ruby-client"
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.rubygems_version = "1.8.11"
  s.summary = "Ruby client for the RoboWhois API."
  s.test_files = ["spec/fixtures/account.dump", "spec/fixtures/account.json", "spec/fixtures/commands.sh", "spec/fixtures/whois.dump", "spec/fixtures/whois.txt", "spec/fixtures/whois/availability/available.dump", "spec/fixtures/whois/availability/available.json", "spec/fixtures/whois/availability/registered.dump", "spec/fixtures/whois/availability/registered.json", "spec/fixtures/whois/properties/available.dump", "spec/fixtures/whois/properties/available.json", "spec/fixtures/whois/properties/registered.dump", "spec/fixtures/whois/properties/registered.json", "spec/fixtures/whois_parts.dump", "spec/fixtures/whois_parts.json", "spec/fixtures/whois_record.dump", "spec/fixtures/whois_record.json", "spec/spec_helper.rb", "spec/support/fake_request_helpers.rb", "spec/support/helpers.rb", "spec/unit/robo_whois_spec.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, ["~> 0.8.0"])
      s.add_development_dependency(%q<rake>, ["~> 0.9"])
      s.add_development_dependency(%q<yard>, [">= 0"])
    else
      s.add_dependency(%q<httparty>, ["~> 0.8.0"])
      s.add_dependency(%q<rake>, ["~> 0.9"])
      s.add_dependency(%q<yard>, [">= 0"])
    end
  else
    s.add_dependency(%q<httparty>, ["~> 0.8.0"])
    s.add_dependency(%q<rake>, ["~> 0.9"])
    s.add_dependency(%q<yard>, [">= 0"])
  end
end
