# open application_file
# see if there is the config.[statement] = [expr]

require 'sugar-high/kind_of'
require 'sugar-high/array'

module RSpec::RailsApp::Content
  module Matchers
    class HaveGems
      extend Rails3::Assist::UseMacro
      use_helpers :file

      include Rails3::Assist::File::Special
    
      attr_reader :names, :name

      def initialize *names
        @names = names.to_strings
      end

      # TODO: relative to root_path ?
      def matches?(root_path=nil)      
        content = read_gem_file
        return nil if content.empty?    
        names.each do |name|
          (content =~ /gem\s+#{name_expr(name)}/)
        end
      end

      def name_expr gem_name
        @name = gem_name
        "('|\")" + gem_name + '\1'
      end

      def msg
        "the Gemfile to have a gem statement: gem '#{name}'"
      end
      
      def version_txt
        version ? ", '#{version}'" : ""
      end
  
      def failure_message
        "Expected #{msg}" 
      end 
    
      def negative_failure_message
        "Did not expect #{msg}" 
      end
    end
                    
    # config.autoload_paths += %W(#{Rails.root}/lib)
    # have_app_config :autoload_paths => '%W(#{Rails.root}/lib)', :op => '+='
    def have_gems *names
      HaveGems.new *names
    end
  end
end
