ENV['GEM_HOME']='./vendor/lib bundle install'
ENV['GEM_PATH']= [`gem env gempath`, './vendor/lib'].join(':')

task :default do
   system "rake --tasks"
end

namespace :bundle do
   desc "Install bundler"
   task :install do
      sh "bundle install"
   end

   desc "Remove Gemfile.local"
   task :clean do
      File.delete 'Gemfile.lock' if File.exists?('Gemfile.lock')
   end
end
