class Topic < ActiveRecord::Base
  attr_accessible :title, :content, :node_id

  belongs_to :user
  belongs_to :node
  has_many :replies, :dependent => :destroy

  validates :title, :presence => true
  validates :content, :presence => true
  validates :user_id, :presence => true

  default_scope :order => 'topics.updated_at DESC'
end
