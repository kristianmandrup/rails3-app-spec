attr_accessor :relative_path

def initialize(relative_path, type = nil)
  @relative_path = relative_rails_file(relative_path, type)
end

def matches?(generator, &block)
  file = File.expand_path(relative_path, Rails.root)
  file_exists = File.exists?(file)
  if block && file_exists
    read = File.read(file)
    ruby_content = read.extend(RSpec::RubyContent::Helpers)
    yield ruby_content
  else
    file_exists
  end        
end          


# REFACTOR

def relative_rails_file path, type = nil                       
  path = path.to_s
  f_name = file_name(path, type)      
  return send :"#{type}_dir" if type        
  File.join(::Rails.root, path)
end

def file_name path, type
  return "#{path}#{postfix(type)}.rb" if !path.include? '.'
  path
end
  

def postfix type
  "_#{type}" if ![:model].include?(type)
end

def folder type
  case type
  when :observer
    'models'
  else
    type == :controller ? type.to_s : type.to_s.pluralize
  end
end      

def base_dir type
  case type
  when :model, :controller, :view, :helper, :observer, :mailer
    'app'
  when :migration
    'db'
  when :javascript, :stylesheet
    'public'
  when :initializer, :locale
    'config'
  else
    ''          
  end
end
