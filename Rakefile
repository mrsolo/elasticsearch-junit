task :default do
   system "rake --tasks"
end

namespace :bundle do
   desc "Install bundler"
   task :install do
      sh "bundle install --binstubs"
   end

   desc "Remove Gemfile.local"
   task :clean do
      File.delete 'Gemfile.lock' if File.exists?('Gemfile.lock')
   end
end
