class RepliesController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @reply = @topic.replies.create(params[:reply])

    redirect_to @topic
  end
end
