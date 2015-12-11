class UserPolicy < ApplicationPolicy

  def show?
    user.admin? || user.id == record.id
  end

end
