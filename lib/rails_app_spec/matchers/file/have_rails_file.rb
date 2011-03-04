require 'rails_app_spec/matchers/file/rails_file_helper'

module RSpec::RailsApp::File
  module Matchers    
    class HaveRailsFile
      include ::RailsAssist::Artifact
      include ::RailsAssist::File
      include RailsFile::Matcher::Helper
    
      def initialize(name, type = nil)
        @type = type if type
        @name = name
      end

      def matches?(obj, &block)
        begin
          @file = type ? send(:"#{type}_file", name) : send(:"#{name}_file")
          File.file? file
        rescue
          false
        end
      end  
    end

    def have_rails_file(name, type=nil)
      HaveRailsFile.new(name, type)
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