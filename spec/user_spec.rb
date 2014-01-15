require_relative './spec_helper'
require_relative '../lib/user'


describe TOM::User do
  after(:each) do
    rm_passwd_file
  end

  let(:email) {'tom@example.com'}
  let(:password) {'password'}
  let(:password_confirmation) {'password'}

  it "#initialize" do
    u = TOM::User.new(email, password, password_confirmation)
    expect(u.email).to eq email
    expect(u.password).to eq password
    expect(u.password_confirmation).to eq password_confirmation
  end

  subject() {TOM::User.new(email, password, password_confirmation)}

  it "#encrypt_password" do
    expect(subject.encrypt_password).to_not eq subject.encrypt_password
  end

  describe "without a password hash" do
    it "save!" do
      expect {subject.save!}.to raise_error UserError
    end
  end

  describe "with a password hash" do
    before(:each) do
      subject.encrypt_password
    end

    it "save!" do
      expect {subject.save!}.not_to raise_error
    end
  end


  describe "saved to the pwd file" do
    before(:each) do
      @user_hash = {}
     %w{tom jill ed dave}.each do |name|
        @user_hash[name] = TOM::User.new("#{name}@example.com", "pw_#{name}", "pw_#{name}")
        @user_hash[name].encrypt_password
        @user_hash[name].save!
      end
    end

    it '#find_by_email' do
      tom = TOM::User.find_by_email('tom@example.com')
      expect(tom).to eq @user_hash['tom'].pwd_str
    end
  end
end

def rm_passwd_file
  File.delete(TOM::User::PWD_FILENAME) if File.exist?(TOM::User::PWD_FILENAME)
end
