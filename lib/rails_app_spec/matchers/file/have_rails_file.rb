module RSpec::RailsApp::File
  module Matchers
    class HaveRailsFile
      include ::Rails::Assist::App

      include Rails::Migration::Assist::ClassMethods
      include ::Rails::Assist::BaseHelper::FileName
      include ::Rails::Assist::Migration::FileName
    
      attr_accessor :name, :artifact_type, :artifact_name

      attr_accessor :folder, :action, :view_ext

      def initialize(name, artifact_type = nil)
        self.artifact_type = artifact_type
        
        if name.kind_of? Hash                  
          view_options  = name
          self.folder   = view_options[:folder]
          self.action   = view_options[:action] 
          self.view_ext = view_options[:view_ext] 
          self.artifact_type = :view
          return nil
        end        
        self.artifact_name = name.to_s
      end

      def matches?(generator, &block)
        self.artifact_name = case artifact_type
        when :view
          File.expand_path(send :"#{artifact_type}_file_name", folder, action, view_ext)          
        else            
          found_file = send :existing_file_name, artifact_name, artifact_type if respond_to? :existing_file_name
          # send :"#{artifact_type}_file_name", artifact_name
        end

        # puts "artifact_name: #{artifact_name}"

        match = File.file? artifact_name      
        if block && match
          yield File.read(artifact_name)
        end
        match        
      end          
  
      def failure_message
        "Expected the #{artifact_type} #{artifact_name} to exist, but it didn't"
      end

      def negative_failure_message
        "Did not expect the #{artifact_type} #{artifact_name} to exist, but it did"
      end
    
    end

    def have_rails_file(relative, artifact_type = nil)
      HaveRailsFile.new(relative, artifact_type)
    end
    alias_method :contain_rails_file, :have_rails_file
  end
end

