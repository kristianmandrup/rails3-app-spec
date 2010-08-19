require 'rspec'
require 'rspec/autorun'
require 'rails3_assist'
require 'rails-app-spec'

RSpec.configure do |config| 
  config.before do                                         
    Rails::Assist::App.rails_root_dir = temp_dir('tmp_rails')
  end

  config.after do
    # remove_temp_dir 'tmp_rails'
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