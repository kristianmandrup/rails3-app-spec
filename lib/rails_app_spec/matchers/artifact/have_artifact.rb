# Combines artifact file exist check with class check!

module RSpec::RailsApp::Artifact
  module Matchers
    class HaveArtifact < RSpec::RubyContentMatcher
      
      include ::Rails::Assist::App
    
      attr_accessor :artifact_type, :artifact_name, :class_type, :content       
      # class      
      attr_accessor :name, :type, :postfix           
      # subclass
      attr_accessor :superclass

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
        # artifact file
        self.artifact_type = artifact_type
        self.postfix = artifact_type.to_s.camelize if has_postfix? artifact_type
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
        self.artifact_name = File.expand_path(send :"#{artifact_type}_file_name", name.downcase)
        @file_found = File.file?(artifact_name)
        return nil if !@file_found

        # check file content for class or subclass
        self.content = File.read(artifact_name)
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
          raise "Class type must be either :class or :subclass, was #{class_type}" 
        end
      end
  
      def failure_message        
        return "Expected the #{type} #{artifact_name} to exist, but it didn't" if !@file_found
        puts "Content: #{content}"
        "Expected the file: #{artifact_name} to have a #{artifact_type} class. The class should #{should_be_msg}"        
      end

      def negative_failure_message
        return "Did not expect the #{type} #{artifact_name} to exist, but it did" if !@file_found
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
  end
end       

