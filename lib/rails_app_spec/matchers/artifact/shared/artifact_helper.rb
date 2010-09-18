module Artifact
  module Matcher
  end
end

module Artifact::Matcher
  module Helper
    attr_accessor :artifact_type, :artifact_name, :class_type, :content       
    # class      
    attr_accessor :name, :type, :postfix           
    # subclass
    attr_accessor :superclass
    
    attr_reader :folder, :action, :view_ext    
    attr_reader :artifact_found, :root_path

    SUPERCLASS_MAP = {
      :observer   => 'ActiveRecord::Observer', 
      :mailer     => 'ActionMailer::Base',
      :migration  => 'ActiveRecord::Migration',
      :permit     => 'Permit::Base'
      }

    POSTFIX = [:helper, :observer, :controller, :mailer, :permit]

    def has_postfix? key
      POSTFIX.include? key
    end    
    
    def parse_type artifact_type
      @artifact_type = artifact_type      
      @postfix = artifact_type.to_s.camelize if has_postfix? artifact_type  
      case artifact_type       
      when :helper, :controller
        # artifact class check 
        @class_type = :class
        @type = :class                          
      when :observer, :migration, :mailer, :permit
        @class_type = :subclass
        # artifact subclass check
        @superclass = SUPERCLASS_MAP[artifact_type]        
      when :model
        # check class == name
        @class_type = :class        
      end
    end

    def parse_name name
      if name.kind_of? Hash                  
        view_options  = name
        @folder   = view_options[:folder]
        @action   = view_options[:action] 
        @view_ext = view_options[:view_ext] 
        @artifact_type = :view
        return nil
      end
      @artifact_name = name.to_s.downcase
      @name = name.to_s.camelize
    end        

    def find_artifact
      artifact_found = case artifact_type
      when :view                                           
        find_view_method = "#{artifact_type}_file_name"
        File.expand_path(send find_view_method, folder, action, view_ext, :root_path => root_path)          
      else                                                     
        find_existing_artifact_method = "existing_#{artifact_type}_file"
        if respond_to? find_existing_artifact_method
          begin
            send find_existing_artifact_method, artifact_name, artifact_type, :root_path => root_path 
          rescue Exception => e 
            @error_msg = e.message
            @trace = e.backtrace.join "\n"
            nil
          end
        else
          raise "The method ##{find_existing_artifact_method} to find the artifact was not available"
        end
      end
      if !artifact_found
        @artifact_found = '[unknown]'
        return nil
      end
  
      @file_found = File.file?(artifact_found)
      return nil if !@file_found

      File.expand_path(artifact_found)                
    end

    SPACES = '\s+'
    OPT_SPACES = '\s*'
    ANY_GROUP = '(.*)'    
    
    # TODO: Refactor, make DRY
    def main_expr
      # determine which regexp to use: class or subclass
      case class_type
      when :subclass
        'class' + SPACES + "#{name}#{postfix}" + OPT_SPACES + '<' + OPT_SPACES + "#{superclass}" + ANY_GROUP      
      when :class
        "#{type}" + SPACES + "#{name}#{postfix}" + SPACES + ANY_GROUP
      else 
        raise "Class type must be either :class or :subclass, was #{class_type}" 
      end
    end

    def alt_end
      'class'
    end

    def should_be_msg
      case class_type
      when :subclass
        "have the name: #{name}#{postfix} and be a subclass of: #{superclass}"
      when :class
        "have the name: #{name}#{postfix}"  
      else           
        raise "Class type must be either :class or :subclass, was #{class_type}" if artifact_type != :view
      end
    end

    def failure_message        
      return "Expected the #{artifact_type} #{artifact_name} to exist at #{artifact_found} (root = #{@root_path}), but it didn't.\nError: #{@error_msg}.\n\nTrace:\n #{@trace}" if !@file_found
      puts "Content: #{content}"
      "Expected the file: #{artifact_name} to have a #{artifact_type} class. The class should #{should_be_msg}"        
    end

    def negative_failure_message
      return "Did not expect the #{artifact_type} #{artifact_name} to exist at #{artifact_found}, but it did" if !@file_found
      puts "Content: #{content}"        
      "Did not expected the file: #{artifact_name} to have a #{artifact_type} class. The class should not #{should_be_msg}"                
    end    
  end
end