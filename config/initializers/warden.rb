require Rails.root.join('lib/warden/strategies/password')

# Failure application for Warden
class UnauthorizedController < ActionController::Metal
  include ActionController::UrlFor
  include ActionController::Redirecting
  include Rails.application.routes.url_helpers
  include Rails.application.routes.mounted_helpers

  delegate :flash, :to => :request

  def self.call(env)
    @respond ||= action(:respond)
    @respond.call(env)
  end

  def respond
    message = env['warden.options'].fetch(:message, "unauthorized.user")
    flash[:alert] = "Unable to login. invalid credentials"
    redirect_to login_url and return
  end
end

Warden::Strategies.add(:password, PasswordStrategy)

# How to serialise user into session
Warden::Manager.serialize_into_session do |user|
  user.id
end

# How to recover user from session
Warden::Manager.serialize_from_session do |id|
  User.find_by_id(id)
end
