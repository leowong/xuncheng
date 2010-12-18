module ApplicationHelper
  def setup_user(user)
    returning(user) do |u|
      u.build_avatar if @user.avatar.nil?
    end
  end
end
