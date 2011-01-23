class Node < ActiveRecord::Base
  attr_accessible :name, :description

  has_many :nodings
  has_many :topics, :through => :nodings
  has_many :groupings
  has_many :users, :through => :groupings

  validates :name, :presence => true
  validates :description, :presence => true
end
