# Combines artifact file exist check with class check!

module RSpec::RailsApp::Artifact
  module Matchers
    class HaveArtifact < RSpec::RubyContentMatcher
      
      include ::Rails::Assist::App

      include Rails::Migration::Assist::ClassMethods
      include ::Rails::Assist::BaseHelper::FileName
      include ::Rails::Assist::Migration::FileName
    
      attr_accessor :artifact_type, :artifact_name, :class_type, :content       
      # class      
      attr_accessor :name, :type, :postfix           
      # subclass
      attr_accessor :superclass

      attr_accessor :folder, :action, :view_ext

      SUPERCLASS_MAP = {
        :observer   => 'ActiveRecord::Observer', 
        :mailer     => 'ActionMailer::Base',
        :migration  => 'ActiveRecord::Migration'
        }

      POSTFIX = [:helper, :observer, :controller]

      def has_postfix? key
        POSTFIX.include? key
      end

      def initialize(name, artifact_type)
        self.artifact_type = artifact_type

        if name.kind_of? Hash                  
          view_options  = name
          self.folder   = view_options[:folder]
          self.action   = view_options[:action] 
          self.view_ext = view_options[:view_ext] 
          self.artifact_type = :view
          return nil
        end        
        
        self.postfix = artifact_type.to_s.camelize if has_postfix? artifact_type
        self.artifact_name = name.to_s.downcase
        self.name = name.to_s.camelize
        
        case artifact_type
        when :helper, :controller
          # artifact class check 
          self.class_type = :class
          self.type = :class
          super name                  
        when :observer, :migration, :mailer
          self.class_type = :subclass
          # artifact subclass check
          self.superclass = SUPERCLASS_MAP[artifact_type]
          super name
        when :model
          # check class == name
          self.class_type = :class
          super name
        end
      end

      def matches?(generator, &block)            
        self.artifact_name = case artifact_type
        when :view
          File.expand_path(send :"#{artifact_type}_file_name", folder, action, view_ext)          
        else                                                     
          if respond_to? :existing_file_name
            send :existing_file_name, artifact_name, artifact_type 
          else
            send :"#{artifact_type}_file_name", artifact_name
          end
        end

        self.artifact_name = File.expand_path(artifact_name)
        
        @file_found = File.file?(artifact_name)
        return nil if !@file_found

        # check file content for class or subclass
        self.content = File.read(artifact_name) 
        
        if artifact_type == :view
          yield content if block
          return true
        end
        super content, &block     
      end          

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
        return "Expected the #{artifact_type} #{artifact_name} to exist, but it didn't" if !@file_found
        puts "Content: #{content}"
        "Expected the file: #{artifact_name} to have a #{artifact_type} class. The class should #{should_be_msg}"        
      end

      def negative_failure_message
        return "Did not expect the #{artifact_type} #{artifact_name} to exist, but it did" if !@file_found
        puts "Content: #{content}"        
        "Did not expected the file: #{artifact_name} to have a #{artifact_type} class. The class should not #{should_be_msg}"                
      end    
    end

    def have_artifact(relative, type = nil)
      HaveArtifact.new(relative, type)
    end
    alias_method :contain_artifact, :have_artifact
    
    (::Rails::Assist.artifacts - [:view]).each do |name|
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

