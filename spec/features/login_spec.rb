require 'rails_helper'

RSpec.describe "the login process", type: :feature do
  let!(:user)              { FactoryGirl.create(:user) }
  let!(:password)          { Faker::Internet.password  }
  let!(:wrong_password)    { Faker::Internet.password  }
  let!(:unknown_user)      { FactoryGirl.build(:user)  }
  before do
    user.password = password
    user.save
  end

  it "sends to the login page on clicking Login" do
    visit '/'
    click_link 'Sign in'
    expect(page).to have_content 'Login'
  end

  it "logs in when given the correct password" do
    visit '/login'
    fill_in 'username', :with => user.username
    fill_in 'password', :with => password
    find('input[type="submit"]').click
    expect(page).to have_content 'Sign out'
  end

  it "does not log the user with incorrect password" do
    visit '/login'
    fill_in 'username', :with => user.username
    fill_in 'password', :with => wrong_password
    find('input[type="submit"]').click
    expect(page).to have_content 'Unable to login'
  end

  it "does not log a non-existent user with" do
    visit '/login'
    fill_in 'username', :with => unknown_user.username
    fill_in 'password', :with => wrong_password
    find('input[type="submit"]').click
    expect(page).to have_content 'Unable to login'
  end

  pending "add some tests for friendly forwarding in #{__FILE__}"

end
