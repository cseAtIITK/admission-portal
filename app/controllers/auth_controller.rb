class AuthController < ApplicationController

  def login_form
  end

  def login
    sign_in
    redirect_to root_path and return
  end

  def logout
    sign_off
    redirect_to root_path and return
  end

end
