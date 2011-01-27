class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show, :new, :create]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @messages = @user.notifications.order('post_id DESC').limit(30)
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(params[:user])

    if User.count == 0
      @user.roles = %w[admin moderator author]
    else
      @user.roles = %w[author]
    end

    if @user.save
      sign_in @user
      redirect_to(root_url, :notice => t('authenticity.flash.signup_successful', :name => @user.username))
    else
      @user.clean_up_passwords
      render :action => "new"
    end
  rescue ActiveRecord::StatementInvalid
    # In the rare case when a race condition occurs
    redirect_to signup_path
  end

  def update
    @user = current_user

    if params[:user]
      if @user.created_at > (Time.now - 24.hours)
        [:roles].map { |p| params[:user].delete(p) }
      else
        [:username, :email, :roles].map { |p| params[:user].delete(p) }
      end

      if params[:user][:password].blank?
        [:password, :password_confirmation, :current_password].map { |p| params[:user].delete(p) }
      else
        unless @user.valid_password?(params[:user][:current_password])
          @user.errors[:base] << t('authenticity.errors.incorrect_password')
        end
      end
    end

    if  @user.errors[:base].empty? && @user.update_attributes(params[:user])
      redirect_to(@user, :notice => t('authenticity.flash.update_successful'))
    else
      @user.clean_up_passwords
      render :action => "edit"
    end
  end
end
