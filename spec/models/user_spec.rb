require 'rails_helper'

RSpec.describe User, type: :model do
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
