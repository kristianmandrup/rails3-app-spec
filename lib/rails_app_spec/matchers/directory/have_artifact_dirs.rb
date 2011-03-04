module RSpec::RailsApp::Directory
  module Matchers    
    class HaveArtifactDirs    
      extend RailsAssist::UseMacro
      use_helper :directory
    
      attr_accessor :artifact_type, :dir, :dir_name, :dirs

      def initialize artifact_type, *dirs
        @artifact_type = artifact_type
        @dirs = dirs
      end

      def matches?(obj, &block)
        dirs.to_strings.each do |dir_name|
          @dir_name = dir_name
          @dir = File.join(send :"#{artifact_type}_dir", dir_name)
          return false if !File.directory?(dir)
        end
        yield if block
        true
      end          
  
      def msg
        "Rails app to have the #{artifact_type} dir: #{dir_name}"
      end
  
      def failure_message
        "Expected #{msg}"
      end

      def negative_failure_message
        "Did not expect #{msg}"
      end   
    end
    
    ::RailsAssist::Directory::App.app_directories.each do |name|
      class_eval %{
        def have_#{name}_dirs *names
          have_artifact_dirs :#{name}, *names
        end    
      }
    end    
  end
end