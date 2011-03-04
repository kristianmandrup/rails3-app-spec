require 'psych'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rails-app-spec"
    gem.summary = %Q{Spec the structure of your Rails 3 app}
    gem.description = %Q{RSpec 2 matchers to help spec the structure and content of your Rails 3 app}
    gem.email = "kmandrup@gmail.com"
    gem.homepage = "http://github.com/kristianmandrup/rails-app-spec"
    gem.authors = ["Kristian Mandrup"]
    gem.add_dependency "rspec",             ">= 2.4.1"
    gem.add_dependency "code-spec",         ">= 0.2.9"
    gem.add_dependency "file-spec",         "~> 0.2.0"
    gem.add_dependency 'migration_assist',  "~> 0.2.0"
    gem.add_dependency "rails_artifactor",  ">= 0.3.3"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end
