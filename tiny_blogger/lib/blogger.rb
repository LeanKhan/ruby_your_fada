# create a tinyyy cms
# Improve this guyyyyy
# - format blogpost titles to acceptable format [x]
# - save blog data in csv file or JSON??? Maybe save the posts in CSV and the general blog information in JSON [?]
# - Add styles to the pages [!]
# - Should be able to delete posts
# - Should be able to edit posts [?]
# - Create themes that users will select on creation
# - Include Date and Time
# - make it cleaner and better [!]
# - add a server [!]
# - make it a command line service... [?]
# - checkout 'Sinatra' a minimalistic (from what I've seen o) Ruby web server framework

# [x] done, [?] optional, [!] important
# require "csv"
require 'erb'
require 'json'
$version = '0.1.0'

puts "Welcome to Tiny Blogger"

def createPage(title, template, is_index)
    Dir.mkdir "pages" unless Dir.exist? "pages"

    title = title.downcase.split(' ').join('-')

    filename = !is_index ? "pages/#{title}.html" : "pages/index.html"

    File.open(filename, "w") do |file|
        file.puts template
    end
end

def doBlog

    puts "Welcome to Tiny Blogger! Please provide a name for your profile:"

    puts "What is your name?"
    name = gets.chomp.downcase

    puts "What is the name of your blog?"
    blog_name = gets.chomp.downcase

    data = {:name => name, :blog_name => blog_name, :date_created => Time.now, :tb_version => $version, :posts => []}

    json_data = JSON.pretty_generate(data)

    filename = '../data/data.json'

    File.open(filename, "w") do |file|
        file.puts json_data
    end

    index_template = File.read "../templates/index.erb"

    index_erb_template = ERB.new index_template

    user_template = index_erb_template.result_with_hash(data)

    createPage(name, user_template, true)
end

def doBlogPost
    puts "This is where you create a tiny-blog post\n\n"

    puts "Please enter the title of the post:"
    title = gets.chomp

    puts "Now write something, at least 5 words long :)"

    content = gets.chomp
end

def getBlogData 
    File.exist? '../data/blog.json'

    blog_data = File.read '../data/data.json'

    puts JSON.parse(blog_data)

end

doBlog