class Asset < ActiveRecord::Base
  attr_accessible :viewable_type, :viewable_id, :attachment, :post_type, :post_id, :used
  belongs_to :viewable, :polymorphic => true, :touch => true
end
