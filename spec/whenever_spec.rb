# require 'spec_helper'
#
# describe 'Whenever Schedule' do
#   before do
#     load 'Rakefile' # Makes sure rake tasks are loaded so you can assert in rake jobs
#   end
#
#   it 'makes sure `rake` statements exist' do
#     require "pry"; binding.pry
#     schedule = Whenever::Test::Schedule.new(vars: { environment: 'development' })
#
#     # Makes sure the rake task is defined:
#     assert Rake::Task.task_defined?(schedule.jobs[:rake].first[:task])
#   end
# end
