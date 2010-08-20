module RSpec::RailsApp::ArtifactFile  
  module Matchers
    include ::Rails::Assist::App
    
    (::Rails::Assist.artifacts - [:view]).each do |name|
      class_eval %{
        def have_#{name}_file relative
          have_rails_file relative, :#{name}
        end
        alias_method :contain_#{name}_file, :have_#{name}_file
      }
    end
    
    def have_view_file folder, action= :show, ext='html.erb'
      have_rails_file "#{folder}/#{action}.#{ext}", :view
    end
    alias_method :contain_view_file, :have_view_file
  end
end   

 