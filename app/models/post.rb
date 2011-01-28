class Post < ActiveRecord::Base
  belongs_to :user, :touch => true
  has_many :callings

  def notify_users
    notify_user(self.user, "author")

    users_to_notify.each do |user|
      notify_user(user, "notification")
    end
  end

  def topic?
    type == "Topic"
  end

  def reply?
    type == "Reply"
  end

  private

  def users_to_notify
    text = content
    text += " " + title if type == "Topic"
    text = text.gsub('@', ' @')
    text.scan(/@(\S+)/).flatten.uniq.map do |name|
      User.find_by_username(name)
    end.select { |user| not user.nil? }
  end

  def notify_user(user, type)
    c = Calling.where(:user_id => user.id, :post_id => self.id)
    if c.empty?
      Calling.create(:user_id => user.id, :post_id => self.id, :types => [type.to_s])
    else
      c.first.add_type(type.to_s)
    end
  end
end
