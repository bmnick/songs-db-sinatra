# This ensures than any further requires refer to the version of the gems that you specify in your Gemfile
require "bundler/setup"
require "pp"

# Use sinatra
require 'sinatra'
require 'sinatra/reloader'

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


get '/songs' do
	@songs = Song.all

	erb :"songs/index"
end

get '/songs/new' do
	@song = Song.new
	@artists = Artist.all

	erb :"songs/new"
end

get '/songs/:id' do |id|
	@song = Song.get(id)

	erb :"songs/show"
end

post '/songs' do
	@song = Song.new(name: params[:song][:name])

	ids = params[:song][:artists].keys.map(&:to_i)

	Artist.all(:id => ids).each do |artist|
		@song.artists << artist
	end

	@song.save

	redirect '/songs'
end

get '/artists' do
	@artists = Artist.all

	erb :"artists/index"
end

get '/artists/new' do
	@artist = Artist.new
	@songs = Song.all

	erb :"artists/new"
end

get '/artist/:id' do |id|
	@artist = Artist.get(id)

	erb :"artists/show"
end

post '/artists' do
	@artist = Artist.new(name: params[:artist][:name])

	ids = params[:artist][:songs].keys.map(&:to_i)

	Song.all(:id => ids).each do |song|
		@artist.songs << song
	end

	@artist.save

	redirect '/artists'
end

