# -*- encoding: utf-8 -*-
# stub: rails-patterns 0.9.0 ruby lib

Gem::Specification.new do |s|
  s.name = "rails-patterns".freeze
  s.version = "0.9.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Stevo".freeze]
  s.date = "2021-06-25"
  s.description = "A collection of lightweight, standardized, rails-oriented patterns.".freeze
  s.email = "b.kosmowski@selleo.com".freeze
  s.extra_rdoc_files = ["LICENSE.txt".freeze, "README.md".freeze]
  s.files = ["LICENSE.txt".freeze, "README.md".freeze]
  s.homepage = "http://github.com/selleo/pattern".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5.0".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "A collection of lightweight, standardized, rails-oriented patterns.".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>.freeze, [">= 4.2.6"])
      s.add_runtime_dependency(%q<actionpack>.freeze, [">= 4.2.6"])
      s.add_runtime_dependency(%q<virtus>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<ruby2_keywords>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 2.0"])
      s.add_development_dependency(%q<juwelier>.freeze, [">= 0"])
    else
      s.add_dependency(%q<activerecord>.freeze, [">= 4.2.6"])
      s.add_dependency(%q<actionpack>.freeze, [">= 4.2.6"])
      s.add_dependency(%q<virtus>.freeze, [">= 0"])
      s.add_dependency(%q<ruby2_keywords>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 2.0"])
      s.add_dependency(%q<juwelier>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<activerecord>.freeze, [">= 4.2.6"])
    s.add_dependency(%q<actionpack>.freeze, [">= 4.2.6"])
    s.add_dependency(%q<virtus>.freeze, [">= 0"])
    s.add_dependency(%q<ruby2_keywords>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 2.0"])
    s.add_dependency(%q<juwelier>.freeze, [">= 0"])
  end
end
