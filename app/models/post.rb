class Post < ActiveRecord::Base
  belongs_to :user, :touch => true
  has_many :callings

  def notify_users
    users_to_notify.each do |user|
      user.notifications << self unless user.notifications.include?(self)
    end
  end

  def topic?
    type == "Topic"
  end

  def reply?
    type == "Reply"
  end

  scope :messages, lambda { |user| messages_of(user) }

  private

  def self.messages_of(user)
    notification_ids = %(SELECT posts.id FROM posts INNER JOIN callings ON posts.id = callings.post_id WHERE (("callings".user_id = :user_id)))
    where("posts.user_id = :user_id OR posts.id IN (#{notification_ids})", { :user_id => user }).
      order("posts.created_at DESC").
      select("DISTINCT posts.*")
  end

  def users_to_notify
    text = content
    text += " " + title if type == "Topic"
    text = text.gsub('@', ' @')
    text.scan(/@(\S+)/).flatten.uniq.map do |name|
      User.find_by_username(name)
    end.select { |user| not user.nil? }
  end
end
