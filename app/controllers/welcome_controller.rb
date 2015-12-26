class WelcomeController < ApplicationController

  # The root page.
  def index
    redirect_to (user_path current_user.id) and return if signed_in?
  end

end
