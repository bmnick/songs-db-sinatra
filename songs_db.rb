# This ensures than any further requires refer to the version of the gems that you specify in your Gemfile
require "bundler/setup"

# Use sinatra
require 'sinatra'

get '/' do
	@name = "Ben"
	erb :index
end

get '/:name' do |name|
	@name = name
	erb :index
end

