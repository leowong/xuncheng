class Noding < ActiveRecord::Base
  belongs_to :node
  belongs_to :topic
end
