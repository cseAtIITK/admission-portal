# The password based authentication strategy.
class PasswordStrategy < Warden::Strategies::Base

  def valid?
    params['username'] || params['password']
  end

  def authenticate!
    u = User.find_by(username: params['username'])
    if u and u.authenticate(params['password'])
      success!(u)
    else
      fail("password.strategy.failed")
    end
  end

end
