require 'rails_helper'

RSpec.describe User, type: :model do
  context "Validation" do
    it "has a valid factory" do
      expect(FactoryGirl.create(:user)).to be_valid
    end

    [:name , :username, :role].each do |f|
      it "is invalid without a #{f}" do
        expect(FactoryGirl.build(:user, f => nil)).not_to be_valid
      end
    end

    let(:user)   { FactoryGirl.create(:user) }

    it "is invalid if username is repeated" do
      expect(FactoryGirl.build(:user, username: user.username)).not_to be_valid
    end

    let!(:candidate) { FactoryGirl.create(:user, :with_email) }

    it "is invalid if email is repeated" do
      expect(FactoryGirl.build(:user, email: candidate.email)).not_to be_valid
    end
  end

  context "Password authentication" do
    let!(:password)       { Faker::Internet.password }
    let!(:new_password)   { Faker::Internet.password }
    let!(:wrong_password) { Faker::Internet.password }

    let(:user)            { FactoryGirl.create(:user, password: password) }

    it "authenticates with the correct password" do
      expect(user.authenticate(password)).to be_truthy
    end

    it "does not authenticate with wrong password" do
      expect(user.authenticate(wrong_password)).to be false
    end

    it "does not allow changing password with incorrect password" do
      expect(user.change_password(wrong_password, new_password, new_password)).to be false
    end

    it "does not allow changing password with incorrect confirm password" do
      expect(user.change_password(password, new_password, wrong_password)).to be false
    end

    it "allows changing password" do
      expect(user.change_password(password, new_password, new_password)).to be_truthy
    end

  end
end
