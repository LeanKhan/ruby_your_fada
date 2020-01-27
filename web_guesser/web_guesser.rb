# web_guesser app thingy
require 'sinatra'
require 'sinatra/reloader'

get '/' do

    srand 1234
    number = rand(101)
    srand 1234

    guess = params["guess"] ? params["guess"].to_i : nil

    if(guess)
        if(guess > number)
            message = "Too High!"
        elsif(guess < number)
            message = "Too Low!"
        else
            message = "Just Right!"
        end
    end

    erb :index, :locals => {:number => number, :message => message, :guess => guess}

end