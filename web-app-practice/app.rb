
require 'sinatra/base'

class Application < Sinatra::Base
  get '/' do
   'This da home page.'
  end

  get '/posts' do
    name = params[:name]
    cohort = params[:cohort]

    "Welcome to the #{cohort} cohort, #{name}."
  end

  get '/hello' do
    name = params[:name]

    "Howdy, #{name}."
  end

  post '/posts' do
    secret_msg = params[:secret_msg]

    "Your secret message has been delivered: '#{secret_msg}'"
  end

  post '/submit' do
    name = params[:name]
    submission = params[:submission]

    "Thanks #{name}, here is your submission: '#{submission}'"
  end
end