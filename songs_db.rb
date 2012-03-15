# This ensures than any further requires refer to the version of the gems that you specify in your Gemfile
require "bundler/setup"
require "pp"

# Use sinatra
require 'sinatra'

# Use datamapper for SQL access
require 'data_mapper'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/songs.db")

class Song
	include DataMapper::Resource

	property :id, Serial
	property :name, String

	has n, :artists, through: Resource
end

class Artist
	include DataMapper::Resource

	property :id, Serial
	property :name, String

	has n, :songs, through: Resource
end

DataMapper.finalize.auto_upgrade!

get '/' do
	@name = Song.all.first.name
	erb :index
end

