require 'faker'

FactoryGirl.define do
  factory :user do |u|
    u.name        { Faker::Name.name }
    u.username    { Faker::Internet.user_name }
    u.role        { [:admin, :grader, :staff, :candidate].sample }
  end

  trait :with_email do
    email        { Faker::Internet.email }
  end

  [:admin, :grader, :staff, :candidate].each do |type|
    trait type do
      role         { type }
    end
  end

end
