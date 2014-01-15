require 'bcrypt'
require 'pry'
require_relative '../logger'

class UserError < StandardError; end

module TOM
  class User
    include TOM::Logger

    PWD_FILENAME = "#{File.dirname(__FILE__)}/../passwd"

    attr_accessor :email, :password, :password_confirmation

    def initialize(email, password = "", password_confirmation = "")
      @email = email
      @password = password
      @password_confirmation = password_confirmation
    end

    def encrypt_password
      @password_salt = BCrypt::Engine.generate_salt
      @password_hash = BCrypt::Engine.hash_secret(password, @password_salt)
    end

    def valid?
      true
    end

    def pwd_str
      "#{@email}:#{@password_hash}:#{@password_salt}\n"
    end

    # The ! means it can throw an exception
    def save!
      raise UserError, ("#{@email} is missing a password hash") if @password_hash.nil?
      raise UserError, "User #{@email} is not valid" unless self.valid?

      File.open(PWD_FILENAME, 'a+') do |pwd_file|
        pwd_file.puts(self.pwd_str)
      end
      print_save_to_screen
    end

    # class method
    def self.find_by_email(email_address)
      entries = []
      File.open(PWD_FILENAME, 'r') do |pwd_file|
  #      entries = pwd_file.read_lines
        entries = pwd_file.readlines
      end
      entries.find do |entry|
        email_address == entry.split(':')[0]
      end
    end
  end
end
