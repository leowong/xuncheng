class Node < ActiveRecord::Base
  attr_accessible :name, :description

  has_many :nodings
  has_many :topics, :through => :nodings

  validates :name, :presence => true
  validates :description, :presence => true
end
