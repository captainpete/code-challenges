require 'rubygems'
begin
  require 'parallel'
rescue LoadError
  $stderr.puts "parallel must be available to run!"
  $stderr.puts "gem install parallel"
end

NUMBERS = %w( 1 2 3 4 5 6 7 8 9 )
LETTERS = %w( A B C D E F )
LETBERS = NUMBERS + LETTERS

MAX_LENGTH = 8

# never contain more than 2 consequtive characters of the same class (number, letter)
# never contain adjacent identical characters
# are always 8 characters in length (the WPA2 minimum it turns out)
# never contain a zero (too easily confused with capital O?)
# always have letters present, always in the set A-F (must be hex then)

def excluded_letbers(two_ago, one_ago)
  if NUMBERS.include?(two_ago) && NUMBERS.include?(one_ago)
    NUMBERS
  elsif LETTERS.include?(two_ago) && LETTERS.include?(one_ago)
    LETTERS
  else
    []
  end
end

def valid_letbers(position, current_password)
  one_ago = current_password[position - 2]
  two_ago = current_password[position - 3]
  LETBERS - [one_ago] - excluded_letbers(two_ago, one_ago)
end

# go through all the numbers and letters as starting points
Parallel.map(LETBERS, :in_processes => 3) do |first|
  current_password = Array.new(8)

  $stderr.puts "Starting keys for #{first}"
  f = File.open("keyspace.#{first}", 'w')

  # first character
  current_password[0] = first

  # second character, can be anything just not the same as the last
  (LETBERS - [first]).each do |second|
    current_password[1] = second

    # third character, can be anything that isn't the same class as the last two (if they're the same), and can't be the same as the last
    # the same valid character determination can applied to positions 3-8
    position = 3
    valid_letbers(position, current_password).each do |valid_letber|
      current_password[position - 1] = valid_letber

      position = 4
      valid_letbers(position, current_password).each do |valid_letber|
        current_password[position - 1] = valid_letber

        position = 5
        valid_letbers(position, current_password).each do |valid_letber|
          current_password[position - 1] = valid_letber

          position = 6
          valid_letbers(position, current_password).each do |valid_letber|
            current_password[position - 1] = valid_letber

            position = 7
            valid_letbers(position, current_password).each do |valid_letber|
              current_password[position - 1] = valid_letber

              position = 8
              valid_letbers(position, current_password).each do |valid_letber|
                current_password[position - 1] = valid_letber
                f.puts(current_password.join)
              end
              position = 7
            end
            position = 6
          end
          position = 5
        end
        position = 4
      end
      position = 3
    end
  end

  f.close
  $stderr.puts "Completed keys for #{first}"
end

