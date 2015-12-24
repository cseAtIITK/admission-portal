require 'rails_helper'

RSpec::Matchers.define :authenticate_with do |pass|
  match do |user|
    user.authenticate(pass)
  end
end

RSpec::Matchers.define :change_password_with do |old,new,confirm|
  match do |user|
    user.change_password(old,new,confirm)
  end
end

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

    let(:candidate) { FactoryGirl.create(:user, :with_email) }

    it "is invalid if email is repeated" do
      expect(FactoryGirl.build(:user, email: candidate.email)).not_to be_valid
    end
  end

  describe "Password management" do
    let(:password)       { Faker::Internet.password }
    let(:new_password)   { Faker::Internet.password }
    let(:wrong_password) { Faker::Internet.password }

    subject      { FactoryGirl.create(:user, password: password) }

    context "#authenticate" do
      it "authenticates with correct password" do
        is_expected.to authenticate_with(password)
      end

      it "does not authenticate with wrong password" do
        is_expected.not_to authenticate_with(wrong_password)
      end
    end


    context "#change_password" do
      it "does not change the password if incorrect password is supplied" do
        is_expected.not_to change_password_with(wrong_password, new_password, new_password)
        is_expected.to authenticate_with(password)
      end

      it "does not change the password if incorrect confirmation is supplied" do
        is_expected.not_to change_password_with(password, new_password, wrong_password)
        is_expected.to authenticate_with(password)
      end

      it "changes password with correct password and confirmation" do
        is_expected.to change_password_with(password, new_password, new_password)
        is_expected.to authenticate_with(new_password)
      end
    end
  end
end
