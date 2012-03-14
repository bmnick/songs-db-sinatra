# This ensures than any further requires refer to the version of the gems that you specify in your Gemfile
require "bundler/setup"

# Use sinatra
require 'sinatra'

# Use datamapper for SQL access
require 'data_mapper'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/songs.db")

class Song
	include DataMapper::Resource

	property :id, Serial
	property :name, String
end

DataMapper.auto_migrate!

get '/' do
	Song.create(:name => "Never Gonna Give You Up").save

	@name = Song.all.first.name
	erb :index
end

