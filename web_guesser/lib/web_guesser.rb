# web_guesser app thingy
require 'sinatra'
require 'sinatra/reloader'

get '/' do
    
    srand 1234
    secret_number = rand(101)
    srand 1234

    "The SECRET NUMBER is #{secret_number}"
end