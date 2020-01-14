# create a tinyyy cms
# Improve this guyyyyy
# - format blogpost titles to acceptable format
# - save blog data in csv file or JSON??? Maybe save the posts in CSV and the general blog information in JSON
# - Add styles to the pages
# - Create themes that users will select on creation
# - Include Date and Time
# - make it cleaner and better
# - add a server?
# - make it a command line service...
# require "csv"
require 'erb'

puts "Welcome to Tiny Blogger"

def createPage(name, template, is_index)
    Dir.mkdir "pages" unless Dir.exist? "pages"

    filename = !is_index ? "pages/#{name}.html" : "pages/index.html"

    File.open(filename, "w") do |file|
        file.puts template
    end
end

def doBlog

    puts "Welcome to Tiny Blogger! Please provide a name for your profile:"

    puts "What is your name?"
    name = gets.chomp.downcase

    index_template = File.read "../templates/index.erb"

    index_erb_template = ERB.new index_template

    user_template = index_erb_template.result(binding)

    createPage(name, user_template, true)
end

def doBlogPost
    puts "This is where you create a tiny-blog post\n\n"

    puts "Please enter the title of the post:"
    title = gets.chomp

    puts "Now write something, at least 5 words long :)"

    content = gets.chomp

    post_template = File.read "../templates/tinypost.erb"

    post_erb_template = ERB.new post_template

    template = post_erb_template.result(binding)

    createPage(title, template, false)
end

if File.exist? "./pages/index.html"
    doBlogPost        
else
    doBlog
end