class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :load_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)

  def show
    @microposts = pagy @user.microposts,
                       items: Settings.settings.per_page_10
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "check_email"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "updated"
      redirect_to @user
    else
      flash.now[:danger] = t "not_updated"
      render :edit
    end
  end

  def index
    @pagy, @user = pagy User.all, items: Settings.settings.per_page_10
  end

  def destroy
    if user.destroy
      flash[:success] = t "deleted"
    else
      flash[:danger] = t "fail"
    end
    redirect_to users_url
  end

  def following
    @title = t "following"
    @pagy, @users = pagy @user.following,
                  items: Settings.settings.per_page_10
    render "show_follow"
  end

  def followers
    @title = t "followers"
    @pagy, @users = pagy @user.followers,
                  items: Settings.settings.per_page_10
    render "show_follow"
  end

  private
  def user_params
    params.require(:user).permit(:name, :email,
                                 :password, :password_confirmation)
  end

  def correct_user
    return if current_user?(@user)

    flash[:danger] = t "access"
    redirect_to root_url
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "not_exist"
    redirect_to :back
  end

  def admin_user
    return if current_user.admin?

    flash[:danger] = t "access"
    redirect_to root_url
  end
end
