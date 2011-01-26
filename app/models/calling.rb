class Calling < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  belongs_to :notification, :class_name => "Post", :foreign_key => "post_id"
end
