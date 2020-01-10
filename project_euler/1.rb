# find the sum of the multiples of 3 or 5 below 1000

def findMultiples number
    sum = 0
    number.times do |n|
        if(n % 3 == 0 || n % 5 == 0)
            sum += n
        end
    end
    puts "Sum is >> #{sum} <<"
end

findMultiples 1000