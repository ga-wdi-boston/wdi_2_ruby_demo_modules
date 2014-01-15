require_relative '../lib/user'


def create_user(email, password, password_confirmation)
  user = TOM::User.new(email, password, password_confirmation)
  user.encrypt_password
  user.save!
end

def prompt_user
  loop do
    print "Enter the user email address: "
    email = gets.chomp

    print "Enter the user password: "
    password = gets.chomp

    print "Confirm the user password: "
    password_confirmation = gets.chomp

    create_user(email, password, password_confirmation)

    print "Create another user?[Y|y]: "
    continue = gets.chomp

    unless continue =~ /Y|y/
      puts "See ya"
      exit
    end

  end

end

if ARGV.length == 3
  create_user(ARGV[0], ARGV[1], ARGV[1])
  # raise ArgumentError, "Usage: create_user email_address password"
else
  prompt_user
end
