# -*- encoding: utf-8 -*-
# stub: vcr-gzip 0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "vcr-gzip"
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Alvaro Bautista"]
  s.date = "2016-11-07"
  s.description = "VCR persister that compresses cassettes using Gzip"
  s.email = ["nvse@novu.com"]
  s.files = [".gitignore", ".rspec", ".travis.yml", "Gemfile", "LICENSE", "README.md", "Rakefile", "lib/vcr-gzip.rb", "lib/vcr-gzip/persister.rb", "lib/vcr-gzip/version.rb", "spec/spec_helper.rb", "spec/vcr-gzip/persister_spec.rb", "spec/vcr-gzip_spec.rb", "vcr-gzip.gemspec"]g
  s.homepage = "http://github.com/novu/vcr-gzip"
  s.rubygems_version = "2.5.1"
  s.summary = "VCR persister that compresses cassettes using Gzip"
  s.test_files = ["spec/spec_helper.rb", "spec/vcr-gzip/persister_spec.rb", "spec/vcr-gzip_spec.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.10.0"])
      s.add_development_dependency(%q<rake>, ["~> 0.9.2"])
      s.add_runtime_dependency(%q<vcr>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.10.0"])
      s.add_dependency(%q<rake>, ["~> 0.9.2"])
      s.add_dependency(%q<vcr>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.10.0"])
    s.add_dependency(%q<rake>, ["~> 0.9.2"])
    s.add_dependency(%q<vcr>, [">= 0"])
  end
end
