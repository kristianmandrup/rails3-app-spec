module ArtifactFile
  module Matcher
  end
end

module ArtifactFile::Matcher
  module Helper
    attr_accessor :name, :artifact_type, :artifact_name
    attr_accessor :folder, :action, :view_ext
    attr_reader :names, :root_path    
    
    def set_view name
      view_options  = name
      self.folder   = view_options[:folder]
      self.action   = view_options[:action] 
      self.view_ext = view_options[:view_ext] 
      self.artifact_type = :view
    end
    
    def handle_view artifact_type, names
      if artifact_type == :view
        lang_option = last_arg({:lang => 'erb.html'}, names)
        raise ArgumentException, ':folder option must be specified in the last hash argument for #have_views' if !lang_option[:folder]          
        self.folder = lang_option[:folder]
        self.view_ext = lang_option[:lang] || {:lang => 'erb.html'}
      end
    end
    
    def get_artifact_name
      case artifact_type
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