class Topic < ActiveRecord::Base
  attr_accessible :title, :content

  belongs_to :user
  has_many :replies, :dependent => :destroy

  validates :title, :presence => true
  validates :content, :presence => true
  validates :user_id, :presence => true

  default_scope :order => 'topics.updated_at DESC'
end
