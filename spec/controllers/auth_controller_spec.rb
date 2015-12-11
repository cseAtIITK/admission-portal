require 'rails_helper'

RSpec.describe AuthController, type: :controller do
  describe "GET login" do
    before do
      get :login_form
    end
    subject { response }
    it { is_expected.to have_http_status :ok    }
    it { is_expected.to render_template(:login_form) }
  end

  # let!(:user)                { FactoryGirl.create(:user) }
  # let!(:correct_pass)        { Faker::Internet.password  }
  # let!(:wrong_pass)          { Faker::Internet.password  }
  # let!(:arbit_user)          { Faker::Internet.user_name }

  # describe "PUT login" do
  #   before do
  #     user.password = correct_pass
  #     post :login, username: user.username, password: correct_pass
  #   end
  #   subject { response }
  #   it { is_expected.to redirect_to root_path }
  # end

end
