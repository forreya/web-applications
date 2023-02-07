# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'
require_relative 'lib/album'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  get '/albums' do
    album_repository = AlbumRepository.new
    all_albums = album_repository.all.map {
      |album|
      album.title
    }.join(', ')
    all_albums
  end

  post '/albums' do
    title = params[:title]
    release_year = params[:release_year]
    artist_id = params[:artist_id]

    album_repository = AlbumRepository.new
    new_album = Album.new
    new_album.title = title
    new_album.release_year = release_year
    new_album.artist_id = artist_id
    album_repository.create(new_album)
    
  end

  get '/artists' do
    artist_repository = ArtistRepository.new
    all_artists = artist_repository.all.map {
      |artist|
      artist.name
    }.join(', ')
    all_artists
  end

  post '/artists' do
    name = params[:name]
    genre = params[:genre]

    artist_repository = ArtistRepository.new
    new_artist = Artist.new
    new_artist.name = name
    new_artist.genre = genre
    artist_repository.create(new_artist)
    
  end

end