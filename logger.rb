module TOM
	module Logger
		def print_save_to_screen
			puts "User #{self.email} has been saved!"
		end

		def authenticate(email, password)
			user = User.find_by_email(email)
			password_salt = user.split(':')[2]
			check_hash = BCrypt::Engine.hash_secret(password, password_salt)
			check_hash == user.password_hash
		end
	end
end
