# Rails app RSpec 2 matchers

RSpec 2 matchers to spec the structure of your Rails 3 app

## Install

<code>gem install rails-app-spec</code>

## Usage

See specs for more details on how to use the API.

Usage example (teaser):
<pre>
  require 'rails3_assist'
  require 'rails-app-spec'  
  
  Rails.root.should have_controller :account do |content|
    content.should have_method :index
  end

  Rails.root.should have_controller_file :account do |controller_file|
    controller_file.should have_controller_class :account do |klass|
      klass.should have_method :index
    end
  end
end  
</pre>  

This library takes advantage of *code-spec*, *file-spec* and other essential spec extensions I have created ;)

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 Kristian Mandrup. See LICENSE for details.
