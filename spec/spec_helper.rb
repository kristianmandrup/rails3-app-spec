require 'rspec/core'
require 'rails_artifactor'
require 'rails_artifactor/rspec'
require 'rails-app-spec'

# require 'generator-spec'
#                              
# RSpec::Generator.configure do |config|
#   config.debug = false
#   config.remove_temp_dir = false # true
#   config.default_rails_root(__FILE__) 
#   config.lib = File.dirname(__FILE__) + '/../lib'
#   config.logger = :stdout  
# end

RSpec.configure do |config| 
  config.before do                                         
    RailsAssist::Directory.rails_root = temp_dir('tmp_rails')
  end

  config.after do
    remove_temp_dir 'tmp_rails'
  end   
end

def project_dir
  File.dirname(__FILE__) + '/..'
end

def temp_dir name
  File.join(project_dir, name)  
end

def make_temp_dir name   
  FileUtils.mkdir_p temp_dir(name)
  temp_dir(name)
end

def remove_temp_dir name   
  FileUtils.rm_rf temp_dir(name)
end
