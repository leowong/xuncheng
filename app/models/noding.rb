class Noding < ActiveRecord::Base
  belongs_to :node
  belongs_to :topic

  validates :node_id, :presence => true
  validates :topic_id, :presence => true
end
