require './app'
require 'sinatra/activerecord/rake'

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = 'test/*_test.rb'
  t.verbose = true
end

task(default: :test)
