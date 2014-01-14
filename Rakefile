require "bundler/gem_tasks"

require 'rake/testtask'
 
Rake::TestTask.new do |t|
  t.libs << 'lib/flf_creator'
  t.test_files = FileList['test/lib/flf_creator/*_test.rb']
  t.verbose = true
end
 
task :default => :test
