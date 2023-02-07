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

  context 'GET to /albums' do
    it 'returns a list of all albums' do
      response = get('/albums')

      expect(response.status).to eq 200
      expect(response.body).to eq 'Doolittle, Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring'
    end
  end

  context 'POST to /albums' do
    it 'returns no content, status is 200 OK' do
      title = 'Voyage'
      release_year = 2022
      artist_id = 2

      response = post('/albums', title: title, release_year: release_year, artist_id: artist_id)
      expect(response.status).to eq 200

      response = get('/albums')
      expect(response.body).to eq 'Doolittle, Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring, Voyage'
    end
  end

  context 'GET to /artists' do
    it 'returns a list of all artists' do
      response = get('/artists')

      expect(response.status).to eq 200
      expect(response.body).to eq 'Pixies, ABBA, Taylor Swift, Nina Simone'
    end
  end

  context 'POST to /artists' do
    it 'returns no content, status is 200 OK' do
      name = 'Teresa Teng'
      genre = 'Pop'

      response = post('/artists', name: name, genre: genre)
      expect(response.status).to eq 200

      response = get('/artists')
      expect(response.body).to eq 'Pixies, ABBA, Taylor Swift, Nina Simone, Teresa Teng'
    end
  end
end
