class Admin < User
  def admin?
    true
  end

  def user?
    false
  end
end
