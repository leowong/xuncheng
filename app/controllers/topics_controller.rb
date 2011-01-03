class TopicsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  include ImagesHelper

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @node = Node.find(params[:node_id])
    @topic = @node.topics.new
  end

  def edit
    @topic = Topic.find(params[:id])
    authorize! :update, @topic
  end

  def create
    @node = Node.find(params[:node_id])
    @topic = Topic.new(params[:topic])
    @topic.nodes = [@node]
    @topic.user_id = current_user.id

    if @topic.save
      @topic.notify_users
      mark_used_images(@topic)
      redirect_to(@topic, :notice => 'Topic was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @topic = Topic.find(params[:id])
    authorize! :update, @topic

    if @topic.update_attributes(params[:topic])
      redirect_to(@topic, :notice => 'Topic was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    authorize! :destroy, @topic

    @topic.destroy
    redirect_to(topics_url)
  end
end
