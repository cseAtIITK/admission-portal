require 'rails_helper'
require 'pundit/rspec'

describe UserPolicy do
  let (:admin_user)          { FactoryGirl.create(:user, :admin)     }
  let (:candidate)           { FactoryGirl.create(:user, :candidate) }
  let (:other_candidate)     { FactoryGirl.create(:user, :candidate) }

  subject { described_class }

  permissions :show? do
    it "should permit admin user" do
      is_expected.to permit(admin_user, candidate)
    end

    it "should permit the same user" do
      is_expected.to permit(candidate, candidate)
    end

    it "should not permit it for another user" do
      is_expected.not_to permit(candidate, other_candidate)
    end

  end
end
