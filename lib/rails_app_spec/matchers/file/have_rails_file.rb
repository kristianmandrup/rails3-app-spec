module RSpec::RailsApp::File
  module Matchers
    class HaveRailsFile
      include ::Rails::Assist::App
    
      attr_accessor :name, :type, :artifact_name

      def initialize(name, type = nil)
        self.name = name
        self.type = type
      end

      def matches?(generator, &block)
        self.artifact_name = send :"#{type}_file_name", name
        match = File.file? artifact_name      
        if block && match
          yield File.read(artifact_name)
        end
        match        
      end          
  
      def failure_message
        "Expected the #{type} #{artifact_name} to exist, but it didn't"
      end

      def negative_failure_message
        "Did not expect the #{type} #{artifact_name} to exist, but it did"
      end
    
    end

    def have_rails_file(relative, type = nil)
      HaveRailsFile.new(relative, type)
    end
    alias_method :contain_rails_file, :have_rails_file
  end
end

