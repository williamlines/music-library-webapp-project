# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end
  
  get '/albums' do
    repo = AlbumRepository.new
    @albums = repo.all

    return erb(:albums)
  end

  get '/albums/new' do
    return erb(:new_album)
  end
  
  def invalid_album_parameters
    params[:title] == nil || params[:release_year] == nil || params[:artist_id] == nil || params[:release_year].to_i.to_s != params[:release_year] || params[:artist_id].to_i.to_s != params[:artist_id]
  end
    
  post '/albums' do
    if invalid_album_parameters
      status 400
      return ''
    end

    # Parameters are valid,
    # the rest of the route can execute.
    title = params[:title]
    release_year = params[:release_year]
    artist_id = params[:artist_id]
    
    repo = AlbumRepository.new
    album = Album.new
    
    album.title = title
    album.release_year = release_year
    album.artist_id = artist_id

    repo.create(album)
      return erb(:album_created)
  end

  get '/artists' do
    repo = ArtistRepository.new
    @artists = repo.all
    
    return erb(:artists)
  end
  
  get '/artists/new' do
    return erb(:new_artist)
  end

  get '/artists/:id' do
    repo = ArtistRepository.new
    artist_id = params[:id]
    @artist = repo.find(artist_id)

    return erb(:an_artist)
  end
  
  def invalid_artist_parameters
    params[:name] == nil || params[:genre] == nil
  end
  
  post '/artists' do
    if invalid_artist_parameters
      status 400
      return ''
    end

    
    repo = ArtistRepository.new
    artist = Artist.new
    artist.name = params[:name]
    artist.genre = params[:genre]

    repo.create(artist)
    return erb(:artist_created)
  end
  
  get '/albums/:id' do
    album_id = params[:id]
    album_repo = AlbumRepository.new
    album = album_repo.find(album_id)
    @title = album.title
    @release_year = album.release_year
    artist_id = album.artist_id
    artist_repo = ArtistRepository.new
    artist = artist_repo.find(artist_id)
    @artist_name = artist.name

    return erb(:an_album)
    
  end
end