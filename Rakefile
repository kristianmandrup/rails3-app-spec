begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rails-app-spec"
    gem.summary = %Q{RSpec 2 matchers to spec the structure of your Rails 3 app}
    gem.description = %Q{RSpec 2 matchers to spec the structure of your Rails 3 app}
    gem.email = "kmandrup@gmail.com"
    gem.homepage = "http://github.com/kristianmandrup/rails-app-spec"
    gem.authors = ["Kristian Mandrup"]
    gem.add_development_dependency "rspec", "~> 2.0.0.beta.22"

    gem.add_dependency "rspec",             "~> 2.0.0.beta.22"
    gem.add_dependency "code-spec",         "~> 0.2.5"
    gem.add_dependency "file-spec",         "~> 0.1.1"        

    gem.add_dependency "activesupport",     "~> 3.0.0"
    gem.add_dependency "require_all",       "~> 1.1.0"
    gem.add_dependency "rails3_artifactor", "~> 0.2.4"
    gem.add_dependency "rails3_assist",     "~> 0.2.10"
    gem.add_dependency "sugar-high",        "~> 0.2.10"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end
