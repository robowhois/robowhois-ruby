# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "robowhois"
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Simone Carletti"]
  s.date = "2013-03-25"
  s.description = "Ruby client for the RoboWhois API."
  s.email = ["weppos@weppos.net"]
  s.files = [".gitignore", ".rspec", ".travis.yml", "CHANGELOG.md", "Gemfile", "LICENSE.txt", "README.md", "Rakefile", "lib/robo_whois.rb", "lib/robo_whois/version.rb", "lib/robowhois.rb", "robowhois.gemspec", "spec/fixtures/account.dump", "spec/fixtures/availability.dump", "spec/fixtures/commands.sh", "spec/fixtures/error_bad_credentials.dump", "spec/fixtures/error_unauthorized.dump", "spec/fixtures/error_whois_server_only_web.dump", "spec/fixtures/whois.dump", "spec/fixtures/whois_parts.dump", "spec/fixtures/whois_properties.dump", "spec/fixtures/whois_properties_available.dump", "spec/fixtures/whois_properties_registered.dump", "spec/fixtures/whois_record.dump", "spec/spec_helper.rb", "spec/support/fake_request_helpers.rb", "spec/support/helpers.rb", "spec/unit/robo_whois_spec.rb"]
  s.homepage = "https://github.com/robowhois/robowhois-ruby"
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.rubygems_version = "1.8.24"
  s.summary = "Ruby client for the RoboWhois API."
  s.test_files = ["spec/fixtures/account.dump", "spec/fixtures/availability.dump", "spec/fixtures/commands.sh", "spec/fixtures/error_bad_credentials.dump", "spec/fixtures/error_unauthorized.dump", "spec/fixtures/error_whois_server_only_web.dump", "spec/fixtures/whois.dump", "spec/fixtures/whois_parts.dump", "spec/fixtures/whois_properties.dump", "spec/fixtures/whois_properties_available.dump", "spec/fixtures/whois_properties_registered.dump", "spec/fixtures/whois_record.dump", "spec/spec_helper.rb", "spec/support/fake_request_helpers.rb", "spec/support/helpers.rb", "spec/unit/robo_whois_spec.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, [">= 0.9"])
      s.add_development_dependency(%q<rake>, [">= 10.0.0"])
      s.add_development_dependency(%q<yard>, [">= 0"])
    else
      s.add_dependency(%q<httparty>, [">= 0.9"])
      s.add_dependency(%q<rake>, [">= 10.0.0"])
      s.add_dependency(%q<yard>, [">= 0"])
    end
  else
    s.add_dependency(%q<httparty>, [">= 0.9"])
    s.add_dependency(%q<rake>, [">= 10.0.0"])
    s.add_dependency(%q<yard>, [">= 0"])
  end
end
