class AuthController < ApplicationController

  def login_form
  end

  def login
    sign_in
    redirect_back_or(user_path current_user.id) and return
  end

  def logout
    sign_off
    redirect_to root_path and return
  end

end
