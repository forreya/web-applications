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

  post '/albums' do
    title = params[:title]
    release_year = params[:release_year]
    artist_id = params[:artist_id]

    album_repository = AlbumRepository.new
    @new_album = Album.new
    @new_album.title = title
    @new_album.release_year = release_year
    @new_album.artist_id = artist_id
    album_repository.create(@new_album)

    return erb(:album_success)
    
  end

  get '/artists' do
    artist_repository = ArtistRepository.new
    @all_artists = artist_repository.all

    return erb(:artists)
  end

  post '/artists' do
    name = params[:name]
    genre = params[:genre]

    artist_repository = ArtistRepository.new
    @new_artist = Artist.new
    @new_artist.name = name
    @new_artist.genre = genre
    artist_repository.create(@new_artist)
    
    return erb(:artist_success)
  end

  get '/albums/new' do
    return erb(:albums_new)
  end

  get '/artists/new' do
    return erb(:artists_new)
  end

  get '/albums/:id' do
    id = params[:id]
    album_repository = AlbumRepository.new
    album = album_repository.find(id)

    @title = album.title
    @release_year = album.release_year
    @artist_id = album.artist_id

    artist_repository = ArtistRepository.new
    artist = artist_repository.find(@artist_id)
    @artist_name = artist.name

    return erb(:albums_id)
  end

  get '/artists/:id' do
    id = params[:id]
    artist_repository = ArtistRepository.new
    artist = artist_repository.find(id)

    @name = artist.name
    @genre = artist.genre

    return erb(:artists_id)
  end

  get '/albums' do
    album_repository = AlbumRepository.new
    @all_albums = album_repository.all

    return erb(:albums)
  end
end