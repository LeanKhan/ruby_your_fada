# web_guesser app thingy
require 'sinatra'
require 'sinatra/reloader'

get '/' do

    srand 1234
    secret_number = rand(101)
    srand 1234

    erb :index, :locals => {:number => secret_number}
end