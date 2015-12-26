require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe "GET index" do
    context "Unauthenticate" do
      before do
        unauthenticated_access
        get :index
      end

      subject { response }
      it { is_expected.to have_http_status :ok    }
      it { is_expected.to render_template(:index) }
    end
    context "Authenticated" do
      let (:user) { FactoryGirl.create(:user) }
      before do
        authenticate_as user
        get :index
      end
      it { is_expected.to redirect_to(user_path user.id) }
    end
  end
end
