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

  # Role predicates

  def admin?
    self.role == 'admin'
  end

  def candidate?
    self.role == 'candidate'
  end

  def grader?
    self.role == 'grader'
  end

  def staff?
    self.role == 'staff'
  end


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

  def change_password(old_password, new_password, confirm_password)

    # Check if the correct password is given.
    return false unless self.authenticate(old_password)
    # Check if new password and confirmed password match
    return false unless new_password == confirm_password


    self.password              = new_password
    self.password_confirmation = confirm_password
    self.save

  end

end
