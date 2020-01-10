class Encryptor

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

    def encrypt string, rotation
        result = []
        result = string.split('').collect do |letter|
           encrypt_letter(letter, rotation)
        end

        result.join
    end

    def decrypt string, rotation
        encrypt(string, -rotation)
    end

    def encrypt_file filename, rotation
        # create read file handle
        file = File.open(filename, 'r')

        file.rewind

        output_file = File.open("#{filename.split('.')[0]}.enc.txt", 'w')

        output_file.write(encrypt(file.read, rotation))

        file.close
        output_file.close
    end

    def decrypt_file filename, rotation
        # create read file handle
        file = File.open(filename, 'r')

        file.rewind

        output_file = File.open("#{filename.split('.enc.txt')[0]}.dec.txt", 'w')

        output_file.write(decrypt(file.read, rotation))

        file.close
        output_file.close
    end
end