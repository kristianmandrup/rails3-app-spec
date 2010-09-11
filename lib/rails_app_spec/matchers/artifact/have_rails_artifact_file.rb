module RSpec::RailsApp::ArtifactFile
  module Matchers
    class HaveRailsArtifactFile

      # include Rails::Migration::Assist::ClassMethods
      include ::Rails3::Assist::Artifact::FileName
      # include ::Rails::Assist::Migration::FileName
    
      attr_accessor :name, :artifact_type, :artifact_name

      attr_accessor :folder, :action, :view_ext

      def initialize(name, artifact_type = nil)
        self.artifact_type = artifact_type

        extend "Rails3::Assist::Artifact::#{artifact_type.to_s.camelize}".constantize
        
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

      def matches?(root_path, &block)
        self.artifact_name = case artifact_type
        when :view                                           
          find_view_method = "#{artifact_type}_file_name"
          File.expand_path(send find_view_method, folder, action, view_ext, :root_path => root_path)          
        else                                                     
          find_existing_artifact_method = "existing_#{artifact_type}_file"
          if respond_to? find_existing_artifact_method
            send find_existing_artifact_method, artifact_name, artifact_type, :root_path => root_path 
          else
            raise "The method ##{find_existing_artifact_method} to find the artifact was not available"
          end
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

    def have_rails_artifact_file(relative, artifact_type = nil)
      HaveRailsArtifactFile.new(relative, artifact_type)
    end
    alias_method :contain_rails_artifact_file, :have_rails_artifact_file
  end
end

