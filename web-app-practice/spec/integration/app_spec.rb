require 'spec_helper'
require 'rack/test'
require_relative '../../app'

describe Application do
  include Rack::Test::Methods

  let(:app) {Application.new}

  context 'GET to /' do
    it 'returns 200 OK with the right content' do
      response = get('/')

      expect(response.status).to eq 200
      expect(response.body).to eq 'This da home page.'
    end
  end

  context 'POST to /submit' do
    it 'returns 200 OK with the right content' do
      response = post('/submit', name: "Ryan", submission: "I am secretly a kaeru.")

      expect(response.status).to eq 200
      expect(response.body).to eq "Thanks Ryan, here is your submission: 'I am secretly a kaeru.'"
    end
  end

  context 'GET to /howdy' do
    it 'returns a howdy message to Ryan' do
      response = get('/howdy', name: "Ryan")

      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Howdy, Ryan!</h1>')
    end

    it 'returns a howdy message to ForReya' do
      response = get('/howdy', name: "ForReya")

      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Howdy, ForReya!</h1>')
    end
  end

  context 'GET to /names' do
    it 'returns a list of the names' do
      response = get('/names', names: 'Mononoke, Chihiro, Totoro.')

      expect(response.status).to eq 200
      expect(response.body).to eq "Mononoke, Chihiro, Totoro."
    end
  end

  context 'POST to /sort-names' do
    it 'return a alphabetically sorted list of the names' do
      response = post('/sort-names', names: 'Joe,Alice,Zoe,Julia,Kieran')

      expect(response.status).to eq 200
      expect(response.body).to eq "Alice,Joe,Julia,Kieran,Zoe"
    end
  end

end
