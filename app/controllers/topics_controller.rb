class TopicsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  include ImagesHelper

  def index
    @topics = Topic.order('updated_at DESC')

    respond_to do |format|
      format.html
      format.rss { render :layout => false }
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @topic.update_reply_counters if @topic.replies.where(:reply_counter => nil).size > 0
    mark_message_read(@topic, params[:r]) if current_user and params[:r]
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

    if @topic.save
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

  private

  def mark_message_read(topic, reply_counter)
    if reply_counter.to_i == 0
      post = topic
    else
      post = Reply.where(:topic_id => topic.id, :reply_counter => params[:r]).first
    end
    calling = current_user.callings.where(:post_id => post.id).first if post
    calling.update_attribute(:read, true) if calling and calling.read.nil?
  end
end
