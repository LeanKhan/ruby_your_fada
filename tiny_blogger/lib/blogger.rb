# create a tinyyy cms
# Improve this guyyyyy
# - format blogpost titles to acceptable format [x]
# - save blog data in csv file or JSON??? Maybe save the posts in CSV and the general blog information in JSON [x]
# - Add styles to the pages [!]
# - Should be able to delete posts
# - Should be able to edit posts [?]
# - Create themes that users will select on creation
# - Include Date and Time [x]
# - make it cleaner and better [!]
# - add a server [x]
# - create a form for users to add new posts... [!]
# - make it a command line service... [?]
# - checkout 'Sinatra' a minimalistic (from what I've seen o) Ruby web server framework [x]

# [x] done, [?] optional, [!] important
# require "csv"
require 'erb'
require 'json'
require 'sinatra'
require 'sinatra/reloader'
$version = '0.1.0'

puts "Welcome to Tiny Blogger"

def createPage(title, template, is_index)
    Dir.mkdir "views" unless Dir.exist? "views"

    title = title.downcase.split(' ').join('-')

    filename = !is_index ? "views/#{title}.html" : "views/index.html"

    File.open(filename, "w") do |file|
        file.puts template
    end
end

# First check if they already have an existing blog
# if yes, just make them make a new post.
# if not, make them create a new blog

def launch
    if File.exist? "../data/data.json"
        doBlogPost(false)
    else
        doBlog
    end
end

def doBlog

    puts "Welcome to Tiny Blogger! Please provide a name for your profile:"

    puts "What is your name?"
    name = gets.chomp.downcase

    puts "What is the name of your blog?"
    blog_name = gets.chomp.downcase

    data = {:name => name, :blog_name => blog_name, :created_at => Time.now.to_i, :tb_version => $version, :posts => []}

    saveData(data)

    # index_template = File.read "../templates/index.erb"

    # index_erb_template = ERB.new index_template

    # user_template = index_erb_template.result_with_hash(data)

    # createPage(name, user_template, true)

    doBlogPost(true)
end

def doBlogPost(new_blog)

    if new_blog
        puts "This is where you create a tiny-blog post\n\n"
        # Say hello and other things
    else
        # do normal
        json_file = File.read "../data/data.json"
    
        json_data = JSON.parse(json_file)

        puts "You have #{json_data["posts"].length} posts already\n\n"

        puts "Please enter the title of your new post:"
        title = gets.chomp
    
        puts "Now write something, at most 50 characters long..."
        putc "=>"
    
        content = gets.chomp
    
        # attach content
    
        post = {:title => title, :content => content, :created_at => Time.now.to_i}
    
        json_data["posts"] << post

        json_data["updated_at"] = Time.now.to_i
    
        saveData(json_data)

        serveBlog(json_data)
    end

    # At the end, generate the webpage

end

def saveData data
    json_data = JSON.pretty_generate(data)
    
    filename = '../data/data.json'

    # Update the data store...
    File.open(filename, "w") do |file|
        file.puts json_data
    end
end

def serveBlog data
   get '/' do
     erb :index, :locals => data
   end
end

launch