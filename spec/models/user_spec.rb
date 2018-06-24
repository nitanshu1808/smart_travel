require "rails_helper"

RSpec.describe User, :type => :model do

  context "validate User" do
    before(:all) do

        data =  { user_name: 'nitanshu18',
                  email:     'nitanshu.nik@gmail.com',
                  password:  'leo123456789'
                }

        @user = User.new(data)
    end

    it "verify user_name presence" do
      expect(@user.user_name?).to eql(true)
    end

    it "verify email" do
      expect(@user.email?).to eql(true)
    end

    it "verify password" do
      expect(@user.present?).to eql(true)
    end

    it "password length" do
      expect(@user.password.length).to satisfy("be greater than 12") { |n| n >= 12 }
    end

    it "email pattern" do
      VALID_EMAIL_REGEX = /\A[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\z/
      expect(@user.email).to match(VALID_EMAIL_REGEX)
    end

    it "save user" do
      expect(@user.save).to eql(true)
    end
  end
end
