class SessionsController < ApplicationController
  before_action :find_user, only: :create
  def new; end

  def create
    if @user&.authenticate params[:session][:password]
      if @user.activated
        login_remember @user
      else
        flash[:warning] = t "not_activated"
        redirect_to root_url
      end
    else
      flash.now[:danger] = t "invalid"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
  def find_user
    @user = User.find_by email: params.dig(:session, :email)&.downcase
  end
end
