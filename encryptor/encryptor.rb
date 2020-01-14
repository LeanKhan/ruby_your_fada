require 'digest'

$password = '5f4dcc3b5aa765d61d8327deb882cf99'

# The year Christopher Columbos reached America *shrug*
$rotations = [14, 9, 2]

# TODO: Find a way to also hide/hash/encrypt the rotation
# numbers. muahahahaha!

class Encryptor

    def initialize

        wrong = true

        while wrong

            puts "\n\nEnter the password to continue :)"

            password = gets.chomp

            hashed_password = Digest::MD5.hexdigest(password)

            if(hashed_password != $password)
                wrong = true
                puts "Wrong password hehe! gotcha ;)"
            else
                wrong = false
                puts "\nWelcome, comrade"
            end
        end

    end

    def cipher rotation
        chars = (' '..'z').to_a

        rotated_chars = chars.rotate(rotation)

        pairs = chars.zip(rotated_chars)

        Hash[pairs]
    end

    def encrypt_letter letter, rotation
        letter = letter.downcase
        cipher(rotation)[letter]
    end

    def encrypt string
        result = []
        counter = 0
        string.split('').each do |letter|
           result << encrypt_letter(letter, $rotations[counter % 3])
           counter += 1
        end

        result.join
    end

    def decrypt string
        result = []
        counter = 0
        string.split('').each do |letter|
           result << encrypt_letter(letter, -$rotations[counter % 3])
           counter += 1
        end

        result.join
    end

    def encrypt_file filename, rotation
        # create read file handle
        file = File.open(filename, 'r')

        file.rewind

        output_file = File.open("#{filename.split('.')[0]}.enc.txt", 'w')

        output_file.write(encrypt(file.read))

        file.close
        output_file.close
    end

    def decrypt_file filename, rotation
        # create read file handle
        file = File.open(filename, 'r')

        file.rewind

        output_file = File.open("#{filename.split('.enc.txt')[0]}.dec.txt", 'w')

        output_file.write(decrypt(file.read))

        file.close
        output_file.close
    end

    def realtime_encrypt

        puts "Enter the unencrypted text:"

        encrypt(gets.chomp)

    end

    def realtime_decrypt

        puts "Enter the encrypted text:"

        decrypt(gets.chomp)
    end
end