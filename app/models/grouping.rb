class Grouping < ActiveRecord::Base
  belongs_to :user
  belongs_to :node

  validates :user_id, :presence => true
  validates :node_id, :presence => true
end
