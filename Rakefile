require 'rake'
require 'rspec/core/rake_task'
 

task :default do
  system "rake --tasks"
end

task :test do
  Rake::Task['test:all'].invoke
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

namespace :test do
  desc "Unit Test"
  RSpec::Core::RakeTask.new(:unit) do |t|
    t.pattern = './test/spec/unit{,*/**}/*_spec.rb'
  end

  task :all => [:unit]
end
