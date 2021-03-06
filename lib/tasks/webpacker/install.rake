WEBPACKER_APP_TEMPLATE_PATH = File.expand_path('../../install/template.rb', __dir__)

namespace :webpacker do
  desc "Install webpacker in this application"
  task :install do
    if Rails::VERSION::MAJOR >= 5
      exec "./bin/rails app:template LOCATION=#{WEBPACKER_APP_TEMPLATE_PATH}"
    else
      exec "./bin/rake rails:template LOCATION=#{WEBPACKER_APP_TEMPLATE_PATH}"
    end
  end
end
