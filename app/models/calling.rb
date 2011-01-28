class Calling < ActiveRecord::Base
  attr_accessible :user_id, :post_id, :types

  belongs_to :user
  belongs_to :post
  belongs_to :notification, :class_name => "Post", :foreign_key => "post_id"

  scope :with_type, lambda { |type| where("types_mask & #{2**TYPES.index(type.to_s)} > 0") }

  TYPES = %w[author notification]

  def types=(types)
    self.types_mask = (types & TYPES).map { |t| 2**TYPES.index(t) }.sum
  end

  def types
    TYPES.reject { |t| ((types_mask || 0) & 2**TYPES.index(t)).zero? }
  end

  def type?(type)
    types.include? type.to_s
  end

  def add_type(type)
    update_attribute(:types_mask, (types_mask || 0) | 2**TYPES.index(type.to_s)) if TYPES.index(type.to_s)
  end
end
