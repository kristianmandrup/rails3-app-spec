module RSpec::RailsApp::Dir
  module Matchers    
    class HaveRailsDir    
      include ::Rails::Assist::App
    
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

    ::Rails::Assist::App::RailsDirs.root_directories.each do |name|
      class_eval %{
        def have_#{name}_dir
          have_rails_dir :#{name}
        end    
      }
    end

    ::Rails::Assist::App::RailsDirs.app_directories.each do |name|
      class_eval %{
        def have_#{name}_dir
          have_rails_dir :#{name}
        end    
      }
    end
  end
end