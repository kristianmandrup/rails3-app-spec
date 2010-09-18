require 'rails_app_spec/matchers/file/rails_file_helper'

module RSpec::RailsApp::File
  module Matchers    
    class HaveRailsFiles
      include ::Rails3::Assist::Artifact
      include ::Rails3::Assist::File
      include RailsFile::Matcher::Helper
    
      attr_reader :names

      def initialize(type, *names)
        @type = type
        @names = names
      end

      def matches?(obj, &block)
        begin
          labels = names.to_strings          
          return false if labels.empty?
          labels.each do |name| 
            @name = name
            @file = send(:"#{type}_file", name)
            return false if !File.file?(file)
          end
          yield if block
          true
        rescue
          false
        end
      end          
    end

    def have_rails_files(type, *names)
      HaveRailsFiles.new(type, *names)
    end

    [:initializer, :db, :migration, :locale, :javascript, :stylesheet].each do |name|
      class_eval %{
        def have_#{name}_files *names
          have_rails_files :#{name}, *names
        end    
      }
    end
  end
end