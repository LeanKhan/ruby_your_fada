# create a tinyyy cms
# Improve this guyyyyy
# - format blogpost titles to acceptable format [x]
# - save blog data in csv file or JSON??? Maybe save the posts in CSV and the general blog information in JSON [x]
# - Add styles to the pages [x]
# - Should be able to delete posts [x]
# - Should be able to edit posts [?]
# - Include Date and Time [x]
# - make it cleaner and better [x]
# - add a server [x]
# - create a form for users to add new posts... [x]
# - checkout 'Sinatra' a minimalistic (from what I've seen o) Ruby web server framework [x]

# [x] done, [?] optional, [!] important, [_] regular to do
# require "csv"
require 'erb'
require 'json'
require 'sinatra'
require 'sinatra/reloader'
$version = '0.1.0'

# [redirect to posts page]
get "/" do
    redirect "/posts"
end

# [get posts, render posts page]
get "/posts" do 
    blog_data = File.read "../data/data.json"

    data = JSON.parse(blog_data)

    data["posts"] = data["posts"].sort_by do |post|
        -post["created_at"].to_i
    end

    erb :index, :locals => data
end

# [add post]
post "/posts" do

    @title = params["title"]

    @content = params["content"]

    savePost(@title, @content)

    redirect "/posts"
end

# [delete post]
get "/posts/delete" do
    @id = params["id"].to_i

    blog_data = File.read "../data/data.json"

    data = JSON.parse(blog_data)

    data["posts"].delete_at(@id)

    saveData(data)

    redirect "/posts"
end

# blog data: data = {:name => name, :blog_name => blog_name, :created_at => Time.now.to_i, :tb_version => $version, :posts => []}

# Save post
def savePost title, content

    json_file = File.read "../data/data.json"
    
    json_data = JSON.parse(json_file)

    post = {:title => title, :content => content, :created_at => Time.now.to_i}
    
    json_data["posts"] << post

    json_data["updated_at"] = Time.now.to_i

    saveData(json_data)
end

# Save JSON data
def saveData data
    json_data = JSON.pretty_generate(data)
    
    filename = '../data/data.json'

    # Update the data store...
    File.open(filename, "w") do |file|
        file.puts json_data
    end
end