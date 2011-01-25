class GroupingsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @node = Node.find(params[:grouping][:node_id])
    current_user.join_group(@node)

    redirect_to @node
  end

  def destroy
    @node = Grouping.find(params[:id]).node
    current_user.quit_group(@node)

    redirect_to @node
  end
end
