class TopicsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  include ImagesHelper

  def index
    @topics = Topic.paginate(:page => params[:page], :order => 'updated_at DESC')

    respond_to do |format|
      if request.xhr?
        format.js
      else
        format.html
        format.rss { render :layout => false }
      end
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @topic.update_reply_counters if @topic.replies.where(:reply_counter => nil).size > 0
    @topic.increment_pageviews

    respond_to do |format|
      format.html
      format.rss { render :layout => false }
    end
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

    if @node.active? and @topic.save
      @topic.notify_users
      mark_used_images(@topic)
      redirect_to(@topic, :notice => t('topics.notice.create_successful'))
    else
      render :action => "new"
    end
  end

  def update
    @topic = Topic.find(params[:id])
    authorize! :update, @topic

    if @topic.update_attributes(params[:topic])
      redirect_to(@topic, :notice => t('topics.notice.update_successful'))
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
