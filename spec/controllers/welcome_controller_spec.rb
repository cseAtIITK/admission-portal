require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe "GET index" do
    before do
      get :index
    end

    subject { response }
    it { is_expected.to have_http_status :ok    }
    it { is_expected.to render_template(:index) }
  end
end
