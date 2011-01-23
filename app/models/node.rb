class Node < ActiveRecord::Base
  attr_accessible :name, :description, :active

  has_many :nodings
  has_many :topics, :through => :nodings
  has_many :groupings
  has_many :users, :through => :groupings

  validates :name, :presence => true, :uniqueness => true
  validates :description, :presence => true

  scope :active, where(:active => true)
end
