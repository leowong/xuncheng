class Reply < ActiveRecord::Base
  attr_accessible :content, :topic_id

  belongs_to :user
  belongs_to :topic, :touch => true

  validates :content, :presence => true
  validates :topic_id, :presence => true

  default_scope :order => 'replies.created_at'
end
