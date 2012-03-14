require "rubygems"
require "bundler/setup"

require 'sinatra/base'

class SongsDB < Sinatra::Base
	get '/' do
		"Hello World!"
	end
end

