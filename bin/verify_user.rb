require_relative '../lib/user'

puts "Enter an email"
email = gets.chomp

puts "Enter password"
password = gets.chomp

if TOM::User.login(email, password)
	puts "User #{email} has logged in"
else
	puts "User #{email} is not allowed"
end
