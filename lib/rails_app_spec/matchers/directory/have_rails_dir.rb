module RSpec::RailsApp::Directory
  module Matchers    
    class HaveRailsDir    
      extend Rails3::Assist::UseMacro
      use_helper :directory
    
      attr_accessor :dir, :type

      def initialize(type = nil)
        @type = type
      end

      def matches?(obj, &block)
        @dir = send :"#{type}_dir"
        File.directory? dir
      end          
  
      def failure_message
        "Expected Rails app to have dir: #{relative_path}, but it didn't"
      end

      def negative_failure_message
        "Did not expected Rails app to have dir: #{relative_path}, but it did"
      end   
    end

    def have_rails_dir(type = nil)
      HaveRailsDir.new(type)
    end

    (Rails3::Assist.artifacts + Rails3::Assist.specials(:all) + Rails3::Assist::Directory::Root.root_directories).each do |name|
      class_eval %{
        def have_#{name}_dir
          have_rails_dir :#{name}
        end    
      }
    end
  end
end