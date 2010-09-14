module RSpec::RailsApp::ArtifactFile
  module Matchers
    class HaveRailsArtifactFiles
      include ::Rails3::Assist::Artifact::FileName
      include ArtifactFile::Matcher::Helper
          
      def initialize(artifact_type, *names)
        @names = names
        extend "Rails3::Assist::Artifact::#{artifact_type.to_s.camelize}".constantize

        handle_view artifact_type, names

        @artifact_type = artifact_type        
      end

      def matches?(root_path, &block)
        names.to_strings.each do |name|       
          @artifact_name = name
          @artifact_name = get_artifact_name
          return false if !File.file?(artifact_name)
        end
        yield if block
        true
      end            
    end

    def have_rails_artifact_files(artifact_type, *names)
      HaveRailsArtifactFiles.new(artifact_type, *names)
    end
    alias_method :contain_rails_artifact_files, :have_rails_artifact_files
    
    (::Rails3::Assist.artifacts - [:view]).each do |name|
      class_eval %{
        def have_#{name}_files *names
          have_rails_artifact_files :#{name}, *names 
        end
        alias_method :contain_#{name}_files, :have_#{name}_files
      }
    end  
    
    def have_view_files *args
      have_rails_artifact_files :view, *args
    end
    alias_method :contain_view_files, :have_view_files
  end
end

