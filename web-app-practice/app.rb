
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

  get '/howdy' do
    @name = params[:name]

    return erb(:howdy)
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

  get '/names' do
    names = params[:names]

    names
  end

  post '/sort-names' do
    names = params[:names]

    names.split(',').sort.join(',')
  end

end