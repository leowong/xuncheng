# encoding: utf-8

class Post < ActiveRecord::Base

  def notify_users
    users_to_notify.each do |user|
      user.notifications << self unless user.notifications.include?(self)
    end
  end

  private

  def users_to_notify
    text = content
    text += " " + title if type == "Topic"
    text.scan(/@(.+?)[，。？……！【】（）：；‘’“”——]*\b/).flatten.uniq.map do |name|
      User.find_by_username(name)
    end.select { |user| not user.nil? }
  end
end
