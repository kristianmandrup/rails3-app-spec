module RSpec::RailsApp::Directory
  module Matchers    
    class HaveRailsDirs    
    
      attr_accessor :dir, :dir_name, :dirs

      def initialize *dirs
        @dirs = dirs
      end

      def matches?(obj, &block)
        dirs.to_strings.each do |dir_name|
          @dir_name = dir_name
          @dir = send :"#{dir_name}_dir"
          return false if !File.directory?(dir)
        end
        yield if block
        true
      end          
  
      def failure_message
        "Expected Rails app to have dir: #{dir_name}, but it didn't"
      end

      def negative_failure_message
        "Did not expected Rails app to have dir: #{dir_name}, but it did"
      end   
    end

    def have_rails_dirs *dirs
      HaveRailsDirs.new *dirs
    end
  end
end