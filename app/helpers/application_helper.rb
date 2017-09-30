module ApplicationHelper
  def is_current_user?(user)
    current_user.id == user.id
  end
end
