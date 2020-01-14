
require "csv"
require "erb"

puts "Event Manager initialized"

def clean_zipcode zipcode
    zipcode.to_s.rjust(5, '0')[0..4]
end

def create_pages id, user_template
    Dir.mkdir "output" unless Dir.exist? "output"

    filename = "output/thanks_#{id}.html"

    File.open(filename, "w") do |file|
        file.puts user_template
    end
end


if(File.exist? "../event_attendees.csv")
    contents = CSV.open "../event_attendees.csv", headers: true, header_converters: :symbol
    template = File.read "../event_attendees.erb"

    erb_template = ERB.new template

    contents.each do |row|
        id = row[0]
        fname = row[:first_name]
        lname = row[:last_name]
        zipcode = clean_zipcode(row[:zipcode])

        user_template = erb_template.result(binding)

        create_pages(id, user_template)

    end
end