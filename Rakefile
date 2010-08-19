begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rails-app-spec"
    gem.summary = %Q{RSpec 2 matchers to spec the structure of your Rails 3 app}
    gem.description = %Q{RSpec 2 matchers to spec the structure of your Rails 3 app}
    gem.email = "kmandrup@gmail.com"
    gem.homepage = "http://github.com/kristianmandrup/rails-app-spec"
    gem.authors = ["Kristian Mandrup"]
    gem.add_dependency "rspec", ">= 2.0.0.beta.19"
    gem.add_dependency "require_all", ">= 1.1.0"
    gem.add_dependency "rails3_assist", ">= 0.2.2"
    gem.add_dependency "code-spec", ">= 0.2.1"
    gem.add_dependency "file-spec", ">= 0.1.1"        
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

# require 'spec/rake/spectask'
# Spec::Rake::SpecTask.new(:spec) do |spec|
#   spec.libs << 'lib' << 'spec'
#   spec.spec_files = FileList['spec/**/*_spec.rb']
# end
# 
# Spec::Rake::SpecTask.new(:rcov) do |spec|
#   spec.libs << 'lib' << 'spec'
#   spec.pattern = 'spec/**/*_spec.rb'
#   spec.rcov = true
# end
# 
# task :spec => :check_dependencies
# 
# task :default => :spec
# 
# require 'rake/rdoctask'
# Rake::RDocTask.new do |rdoc|
#   version = File.exist?('VERSION') ? File.read('VERSION') : ""
# 
#   rdoc.rdoc_dir = 'rdoc'
#   rdoc.title = "rails-app-spec #{version}"
#   rdoc.rdoc_files.include('README*')
#   rdoc.rdoc_files.include('lib/**/*.rb')
# end
