# Some common helpers for building contoller specs.
require 'rspec/rails'

module AuthenticationMocks
  def authenticate_as user
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return user
    allow_any_instance_of(ApplicationController).to receive(:signed_in?).and_return user.present?
  end

  def unauthenticated_access
    authenticate_as nil
  end

  def authenticate_as_grader
    authenticate_as  FactoryGirl.build(:user, :grader)
  end

  def authenticate_as_admin
    authenticate_as FactoryGirl.build(:user, :admin)
  end

  def authenticate_as_staff
    authenticate_as FactoryGirl.build(:user, :staff)
  end

  def authenticate_as_candidate
    authenticate_as FactoryGirl.build(:user, :candidate)
  end

end

RSpec.configure do |config|
  config.include AuthenticationMocks
end
