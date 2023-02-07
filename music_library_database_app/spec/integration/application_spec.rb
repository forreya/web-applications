require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  def reset_albums_table
    seed_sql = File.read('spec/seeds/albums_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  def reset_artists_table
    seed_sql = File.read('spec/seeds/artists_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_albums_table
    reset_artists_table
  end

  context 'GET to /albums/new' do
    it 'sends a POST request to /albums' do
      response = get('/albums/new')

      expect(response.status).to eq 200
      expect(response.body).to include('<form action="/albums" method="POST">')
    end
  end

  context 'GET to /artists/new' do
    it 'sends a POST request to /artists' do
      response = get('/artists/new')

      expect(response.status).to eq 200
      expect(response.body).to include('<form action="/artists" method="POST">')
    end
  end

  context 'GET to /albums' do
    it 'returns a list of all albums in HTML form' do
      response = get('/albums')

      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Albums</h1>') 
      expect(response.body).to include('Title: Doolittle')
      expect(response.body).to include('Title: Folklore')
    end
  end

  context 'POST to /albums' do
    it 'returns no content, status is 200 OK' do
      title = 'Voyage'
      release_year = 2022
      artist_id = 2

      response = post('/albums', title: title, release_year: release_year, artist_id: artist_id)
      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Album created: Voyage</h1>')

      response = get('/albums')
      expect(response.body).to include('Title: Voyage')
      expect(response.body).to include('Released: 2022')
    end
  end

  context 'GET to /artists' do
    it 'returns a list of all artists in HTML form' do
      response = get('/artists')

      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Artists</h1>') 
      expect(response.body).to include('Name: Taylor Swift')
      expect(response.body).to include('Name: Nina Simone')
    end
  end

  context 'POST to /artists' do
    it 'returns no content, status is 200 OK' do
      name = 'Teresa Teng'
      genre = 'Pop'

      response = post('/artists', name: name, genre: genre)
      expect(response.status).to eq 200

      response = get('/artists')
      expect(response.body).to include('Name: Teresa Teng')
    end
  end

  context 'GET to /albums/:id' do
    it 'returns HTML content displaying information on the album for ID 1' do
      response = get('/albums/1')

      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Doolittle</h1>')
      expect(response.body).to include('Release year: 1989')
      expect(response.body).to include('Artist: Pixies')
    end

    it 'returns HTML content displaying information on the album for ID 2' do
      response = get('/albums/2')
  
      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Surfer Rosa</h1>')
      expect(response.body).to include('Release year: 1988')
      expect(response.body).to include('Artist: Pixies')

    end
  end

  context 'GET to /artists/:id' do
    it 'returns HTML content displaying information on the artist for ID 1' do
      response = get('/artists/1')

      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Pixies</h1>')
      expect(response.body).to include('Genre: Rock')
    end

    it 'returns HTML content displaying information on the album for ID 2' do
      response = get('/artists/2')
  
      expect(response.status).to eq 200
      expect(response.body).to include('<h1>ABBA</h1>')
      expect(response.body).to include('Genre: Pop')

    end
  end
end
