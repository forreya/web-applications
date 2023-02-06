require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context 'POST to /albums' do
    it 'returns no content, status is 200 OK' do
      title = 'Voyage'
      release_year = 2022
      artist_id = 2

      response = post('/albums', title: title, release_year: release_year, artist_id: artist_id)
      expect(response.status).to eq 200

      response = get('/albums')
      
    end
  end
end
