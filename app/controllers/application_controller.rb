class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :warden, :current_user, :signed_in?


  # Get the currently authorized user
  def current_user
    warden.user
  end

  # Authenticate.
  def authenticate!
    warden.authenticate!
  end

  # Get the warden date.
  def warden
    request.env['warden']
  end

end
