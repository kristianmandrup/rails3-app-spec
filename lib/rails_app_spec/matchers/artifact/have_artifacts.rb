# Combines artifact file exist check with class check!
module RSpec::RailsApp::Artifact
  module Matchers
    class HaveArtifacts < RSpec::RubyContentMatcher
      extend Rails3::Assist::UseMacro
      use_helpers :file

      include ArtifactFile::Matcher::Helper    
      include Artifact::Matcher::Helper    

      attr_reader :names

      def initialize(artifact_type, *names)
        extend "Rails3::Assist::Artifact::#{artifact_type.to_s.camelize}".constantize        
        @names = names
        parse_type artifact_type
        if artifact_type == :view
          handle_view artifact_type, names
        else
          super name        
        end                
      end

      def matches?(root_path, &block)
        @root_path = root_path
        begin          
          labels = names.to_strings          
          return false if labels.empty?
          labels.each do |name| 
            parse_name name              
            
            @artifact_found = find_artifact
            @artifact_name = name
            
            return false if !artifact_found
            return false if !File.file? artifact_found

            # check file content for class or subclass
            self.content = File.read(artifact_found) 
        
            res = if artifact_type == :view            
              true
            else
              super content         
            end
            return false if !res
          end
          yield if block
          true
        rescue
          nil
        end
      end  

      protected
      
      def parse_name name
        if name.kind_of? Hash                  
          self.action = name
          return nil
        end
        self.artifact_name = name.to_s.downcase
        self.name = name.to_s.camelize
      end        
    end

    def have_artifacts(type, *names)
      HaveArtifacts.new(type, *names)
    end
    alias_method :contain_artifact, :have_artifact
    
    (::Rails3::Assist.artifacts - [:view]).each do |name|
      plural_name = name.to_s.pluralize
      class_eval %{
        def have_#{plural_name} *names
          have_artifacts :#{name}, *names 
        end
        alias_method :contain_#{plural_name}, :have_#{plural_name}
      }
    end  
    
    def have_views folder, *args
      have_artifacts :view, *args
    end
    alias_method :contain_view, :have_view
  end
end       

