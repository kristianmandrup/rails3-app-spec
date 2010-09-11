require 'rspec'
require 'rails3_artifactor'
require 'rails3_assist'
require 'require_all'
require 'code-spec'
require 'active_support/inflector'
require 'file-spec'

module RSpec
  module RailsApp      
    module Artifact
    end

    module ArtifactClass
    end

    module ArtifactFile
    end

    module File
    end

    module Dir
    end
  end
end

require_all File.dirname(__FILE__) + '/rails_app_spec/matchers'
                   
RSpec.configure do |config|
  config.include RSpec::RailsApp::File::Matchers
  config.include RSpec::RailsApp::Dir::Matchers
  config.include RSpec::RailsApp::Artifact::Matchers
  config.include RSpec::RailsApp::ArtifactClass::Matchers
  config.include RSpec::RailsApp::ArtifactFile::Matchers
end
