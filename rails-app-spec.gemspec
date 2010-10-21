# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rails-app-spec}
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kristian Mandrup"]
  s.date = %q{2010-10-21}
  s.description = %q{RSpec 2 matchers to help spec the structure and content of your Rails 3 app}
  s.email = %q{kmandrup@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.markdown"
  ]
  s.files = [
    ".document",
     ".gitignore",
     ".rspec",
     "LICENSE",
     "README.markdown",
     "Rakefile",
     "VERSION",
     "lib/rails-app-spec.rb",
     "lib/rails_app_spec/matchers.rb",
     "lib/rails_app_spec/matchers/artifact.rb",
     "lib/rails_app_spec/matchers/artifact/class/have_artifact_class.rb",
     "lib/rails_app_spec/matchers/artifact/class/have_artifact_subclass.rb",
     "lib/rails_app_spec/matchers/artifact/have_artifact.rb",
     "lib/rails_app_spec/matchers/artifact/have_artifact_file.rb",
     "lib/rails_app_spec/matchers/artifact/have_artifacts.rb",
     "lib/rails_app_spec/matchers/artifact/have_rails_artifact_file.rb",
     "lib/rails_app_spec/matchers/artifact/have_rails_artifact_files.rb",
     "lib/rails_app_spec/matchers/artifact/shared/artifact_file_helper.rb",
     "lib/rails_app_spec/matchers/artifact/shared/artifact_helper.rb",
     "lib/rails_app_spec/matchers/directory/have_artifact_dirs.rb",
     "lib/rails_app_spec/matchers/directory/have_rails_dir.rb",
     "lib/rails_app_spec/matchers/directory/have_rails_dirs.rb",
     "lib/rails_app_spec/matchers/file/have_rails_file.rb",
     "lib/rails_app_spec/matchers/file/have_rails_files.rb",
     "lib/rails_app_spec/matchers/file/rails_file_helper.rb",
     "lib/rails_app_spec/matchers/special/have_app_config.rb",
     "lib/rails_app_spec/matchers/special/have_gem.rb",
     "lib/rails_app_spec/matchers/special/have_gems.rb",
     "lib/rails_app_spec/namespaces.rb",
     "lib/rails_app_spec/rspec.rb",
     "lib/rails_app_spec/rspec/configure.rb",
     "rails-app-spec.gemspec",
     "spec/rails_app_spec/matchers/artifact/controller_spec.rb",
     "spec/rails_app_spec/matchers/artifact/core/have_artifacts_spec.rb",
     "spec/rails_app_spec/matchers/artifact/helper_spec.rb",
     "spec/rails_app_spec/matchers/artifact/mailer_spec.rb",
     "spec/rails_app_spec/matchers/artifact/migration/migration_simple_number_spec.rb",
     "spec/rails_app_spec/matchers/artifact/migration/migration_spec.rb",
     "spec/rails_app_spec/matchers/artifact/model_mongoid_spec.rb",
     "spec/rails_app_spec/matchers/artifact/model_spec.rb",
     "spec/rails_app_spec/matchers/artifact/observer_spec.rb",
     "spec/rails_app_spec/matchers/artifact/view_spec.rb",
     "spec/rails_app_spec/matchers/directory/have_rails_dir_spec.rb",
     "spec/rails_app_spec/matchers/directory/have_rails_dirs_spec.rb",
     "spec/rails_app_spec/matchers/file/have_rails_file_spec.rb",
     "spec/rails_app_spec/matchers/file/have_rails_files_spec.rb",
     "spec/rails_app_spec/matchers/special/have_app_config_spec.rb",
     "spec/rails_app_spec/matchers/special/have_gem_spec.rb",
     "spec/rails_app_spec/matchers/special/have_gems_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/kristianmandrup/rails-app-spec}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Spec the structure of your Rails 3 app}
  s.test_files = [
    "spec/rails_app_spec/matchers/artifact/controller_spec.rb",
     "spec/rails_app_spec/matchers/artifact/core/have_artifacts_spec.rb",
     "spec/rails_app_spec/matchers/artifact/helper_spec.rb",
     "spec/rails_app_spec/matchers/artifact/mailer_spec.rb",
     "spec/rails_app_spec/matchers/artifact/migration/migration_simple_number_spec.rb",
     "spec/rails_app_spec/matchers/artifact/migration/migration_spec.rb",
     "spec/rails_app_spec/matchers/artifact/model_mongoid_spec.rb",
     "spec/rails_app_spec/matchers/artifact/model_spec.rb",
     "spec/rails_app_spec/matchers/artifact/observer_spec.rb",
     "spec/rails_app_spec/matchers/artifact/view_spec.rb",
     "spec/rails_app_spec/matchers/directory/have_rails_dir_spec.rb",
     "spec/rails_app_spec/matchers/directory/have_rails_dirs_spec.rb",
     "spec/rails_app_spec/matchers/file/have_rails_file_spec.rb",
     "spec/rails_app_spec/matchers/file/have_rails_files_spec.rb",
     "spec/rails_app_spec/matchers/special/have_app_config_spec.rb",
     "spec/rails_app_spec/matchers/special/have_gem_spec.rb",
     "spec/rails_app_spec/matchers/special/have_gems_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_runtime_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_runtime_dependency(%q<code-spec>, ["~> 0.2.7"])
      s.add_runtime_dependency(%q<file-spec>, ["~> 0.1.3"])
      s.add_runtime_dependency(%q<activesupport>, [">= 3.0.0"])
      s.add_runtime_dependency(%q<require_all>, ["~> 1.2.0"])
      s.add_runtime_dependency(%q<rails3_artifactor>, ["~> 0.3.0"])
      s.add_runtime_dependency(%q<rails3_assist>, ["~> 0.3.0"])
      s.add_runtime_dependency(%q<sugar-high>, ["~> 0.3.0"])
    else
      s.add_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_dependency(%q<code-spec>, ["~> 0.2.7"])
      s.add_dependency(%q<file-spec>, ["~> 0.1.3"])
      s.add_dependency(%q<activesupport>, [">= 3.0.0"])
      s.add_dependency(%q<require_all>, ["~> 1.2.0"])
      s.add_dependency(%q<rails3_artifactor>, ["~> 0.3.0"])
      s.add_dependency(%q<rails3_assist>, ["~> 0.3.0"])
      s.add_dependency(%q<sugar-high>, ["~> 0.3.0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 2.0.0"])
    s.add_dependency(%q<rspec>, [">= 2.0.0"])
    s.add_dependency(%q<code-spec>, ["~> 0.2.7"])
    s.add_dependency(%q<file-spec>, ["~> 0.1.3"])
    s.add_dependency(%q<activesupport>, [">= 3.0.0"])
    s.add_dependency(%q<require_all>, ["~> 1.2.0"])
    s.add_dependency(%q<rails3_artifactor>, ["~> 0.3.0"])
    s.add_dependency(%q<rails3_assist>, ["~> 0.3.0"])
    s.add_dependency(%q<sugar-high>, ["~> 0.3.0"])
  end
end

