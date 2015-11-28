require 'digest/bubblebabble'
class User < ActiveRecord::Base


  has_secure_password
  before_validation :set_password_if_required, :on => :create

  validates :name, :username, :role, presence: true
  validates :username, uniqueness: true
  validates :email, uniqueness: true, allow_nil: true


  enum role: [ :admin,    # The Omni-potent god
               :grader,   # One who enters the grades
               :staff,    # Marks the arrival of drafts and fees etc.
               :candidate # Finally the candidates.
             ]


  def set_password_if_required
    if self.password_digest.blank?
      self.set_random_password
    end
  end

  def set_random_password
    pass=Digest.bubblebabble(SecureRandom.random_bytes 8)
    self.password = pass
    return pass
  end

end
