module ArtifactFile
  module Matcher
  end
end

module ArtifactFile::Matcher
  module Helper
    include ::Rails3::Assist::Artifact::View::FileName
    
    attr_reader :name, :artifact_type, :artifact_name
    attr_reader :folder, :action, :view_ext
    attr_reader :names, :root_path    
    
    def set_view name
      view_options  = name
      @folder   = view_options[:folder]
      @action   = view_options[:action] 
      @view_ext = view_options[:view_ext] 
      @artifact_type = :view
    end
    
    def handle_view artifact_type, names
      if artifact_type == :view
        lang_option = last_arg({:lang => 'erb.html'}, names)
        raise ArgumentException, ':folder option must be specified in the last hash argument for #have_views' if !lang_option[:folder]          
        @folder = lang_option[:folder]
        @view_ext = get_view_ext(lang_option[:lang] || :erb)        
      end
    end
    
    def get_view_ext(ext)
      case ext.to_sym
      when :erb
        'erb.html'
      when :haml
        'haml.html'
      else
        ext.to_s
      end
    end
    
    def get_artifact_name
      case artifact_type
      when :view
        path = send(:view_file_name, folder, artifact_name) #, view_ext, :root_path => root_path)
      else                                                     
        find_existing_artifact_method = "existing_#{artifact_type}_file"
        if respond_to? find_existing_artifact_method
          send find_existing_artifact_method, artifact_name, artifact_type, :root_path => root_path 
        else
          raise "The method ##{find_existing_artifact_method} to find the artifact was not available"
        end
      end
    end
    
    def msg
      "the #{artifact_type} #{artifact_name} to exist"
    end

    def failure_message
      "Expected #{msg}"
    end

    def negative_failure_message
      "Did not expect #{msg}"
    end          
  end
end