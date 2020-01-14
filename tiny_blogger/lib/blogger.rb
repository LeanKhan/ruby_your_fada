# create a tinyyy cms
require 'erb'

def createPage(name, template)
    Dir.mkdir "pages" unless Dir.exist? "pages"

    filename = "pages/#{name}.html"

    File.open(filename, "w") do |file|
        file.puts template
    end
end

def doBlog

    template = File.read "../sample.erb"

    erb_template = ERB.new template

    puts "What is you name?"
    name = gets.chomp.downcase

    user_template = erb_template.result(binding)

    createPage(name, user_template)
end

doBlog