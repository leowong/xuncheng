class Topic < ActiveRecord::Base
  attr_accessible :title, :content

  has_many :replies, :dependent => :destroy

  validates :title, :presence => true
  validates :content, :presence => true
end
