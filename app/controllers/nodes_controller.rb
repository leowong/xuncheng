class NodesController < ApplicationController
  before_filter :authenticate_user!, :except => :show
  load_and_authorize_resource

  def index
    @nodes = Node.all
  end

  def show
    @node = Node.find(params[:id])
  end

  def new
    @node = Node.new
  end

  def edit
    @node = Node.find(params[:id])
  end

  def create
    unless current_user.role?(:admin)
      params[:node][:active] = true
    end
    @node = Node.new(params[:node])

    if @node.save
      @node.users << current_user
      redirect_to(@node, :notice => t('nodes.notice.create_successful'))
    else
      render :action => "new"
    end
  rescue ActiveRecord::StatementInvalid
    redirect_to new_node_path
  end

  def update
    @node = Node.find(params[:id])

    if @node.update_attributes(params[:node])
      redirect_to(@node, :notice => t('nodes.notice.update_successful'))
    else
      render :action => "edit"
    end
  end

  def destroy
    @node = Node.find(params[:id])
    @node.destroy

    redirect_to(nodes_url)
  end
end
