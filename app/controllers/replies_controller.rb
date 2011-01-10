class RepliesController < ApplicationController
  before_filter :authenticate_user!
  include ImagesHelper

  def create
    @last_reply_counter = params[:last_reply_counter]
    params[:reply].delete(:last_reply_counter)
    @topic = Topic.find(params[:topic_id])
    @reply = current_user.replies.create(params[:reply].merge(:topic_id => @topic.id))
    @reply.update_counter
    @reply.notify_users
    mark_used_images(@reply) if @reply
    @replies = @topic.replies.order('created_at').where('reply_counter > ?', @last_reply_counter)

    respond_to do |format|
      if @reply
        format.html { redirect_to @topic }
        format.js
      else
        format.html { redirect_to @topic }
      end
    end
  end
end
