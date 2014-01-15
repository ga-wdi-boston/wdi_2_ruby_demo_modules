module TOM
	class LoginFailed < StandardError; end

	module Authenticator
		def login(email_address, password)
			user = User.find_by_email(email_address)
			raise LoginFailed, "Failed login for #{email_address}" if user == nil

			password_salt = user.split(':')[2]
			user_password_hash = user.split(':')[1]
			new_password_hash = BCrypt::Engine.hash_secret(password, password_salt)
			new_password_hash == user_password_hash
		end
	end
end
