# Combines artifact file exist check with class check!

module RSpec::RailsApp::Artifact
  module Matchers
    class HaveArtifact < RSpec::RubyContentMatcher      
      include Rails3::Assist::Artifact::FileName
      include Artifact::Matcher::Helper

      def initialize(name, artifact_type)
        extend "Rails3::Assist::Artifact::#{artifact_type.to_s.camelize}".constantize
        
        parse_name name
        parse_type artifact_type
        super name if artifact_type != :view
      end

      def matches?(root_path, &block)
        @root_path = root_path
        begin
          artifact_found = find_artifact                
          return nil if !artifact_found

          # check file content for class or subclass
          self.content = File.read(artifact_found) 
        
          if artifact_type == :view
            yield content if block
            return true
          end
          super content, &block     
        rescue
          false
        end
      end   
    end

    def have_artifact(relative, type = nil)
      HaveArtifact.new(relative, type)
    end
    alias_method :contain_artifact, :have_artifact
    
    (::Rails3::Assist.artifacts - [:view]).each do |name|
      class_eval %{
        def have_#{name} relative
          have_artifact relative, :#{name}
        end
        alias_method :contain_#{name}, :have_#{name}
      }
    end  
    
    def have_view folder, action=nil, view_ext=nil      
      arg = {:folder => folder, :action => action, :view_ext => view_ext}
      have_artifact arg, :view
    end
    alias_method :contain_view, :have_view
  end
end       

