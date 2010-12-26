class ImagesController < ApplicationController
  def new
    @user = current_user
    @image = @user.images.new

    render :layout => "popup"
  end

  def create
    @user = current_user
    @image = @user.images.build(params[:image])

    if @image.save
      render :action => "create", :layout => false
    else
      render :action => "new", :layout => "popup"
    end
  end
end
