class RepliesController < ApplicationController
  before_filter :authenticate_user!
  include ImagesHelper

  def create
    @topic = Topic.find(params[:topic_id])
    @reply = current_user.replies.create(params[:reply].merge(:topic_id => @topic.id))
    mark_used_images(@reply) if @reply

    redirect_to @topic
  end
end
