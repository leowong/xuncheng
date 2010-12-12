class RepliesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @topic = Topic.find(params[:topic_id])
    @reply = current_user.replies.create(params[:reply].merge(:topic_id => @topic.id))

    redirect_to @topic
  end
end
