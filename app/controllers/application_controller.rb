class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?

  # Pundit stuff
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorised

  # Get the currently authorized user
  def current_user(*args)
    warden.user(*args)
  end

  def signed_in?(*args)
    warden.authenticated?(*args)
  end

  def sign_in(*args)
    warden.authenticate!(*args)
  end
  def sign_off(*args)
    warden.raw_session.inspect
    warden.logout(*args)
  end

  # Get the warden date.
  def warden
    request.env['warden']
  end

  def user_not_authorised
    flash[:alert] = "The current credentials do not allow this action. Login as a different user."
    redirect_to login_path
  end

end
