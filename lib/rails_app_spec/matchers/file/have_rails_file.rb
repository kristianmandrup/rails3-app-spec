module RSpec::RailsApp::File
  module Matchers    
    class HaveRailsFile
      include ::Rails3::Assist::Artifact
    
      attr_reader :file, :type, :name

      def initialize(name, type = nil)
        @type = type if type
        @name = name
      end

      def matches?(obj, &block)
        @file = type ? send(:"#{type}_file", name) : send(:"#{name}_file")
        File.file? file
      end          
  
      def failure_message
        "Expected Rails app to have file: #{file}, but it didn't"
      end

      def negative_failure_message
        "Did not expected Rails app to have file: #{file}, but it did"
      end   
    end

    def have_rails_file(type = nil)
      HaveRailsFile.new(type)
    end

    [:initializer, :db, :migration, :locale, :javascript, :stylesheet].each do |name|
      class_eval %{
        def have_#{name}_file name
          have_rails_file name, :#{name}
        end    
      }
    end

    [:application, :seed, :environment].each do |name|
      class_eval %{
        def have_#{name}_file
          have_rails_file #{name}
        end    
      }
    end
  end
end