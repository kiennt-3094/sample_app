class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :load_user_followed, only: :create
  before_action :load_relationship, only: :destroy

  def create
    current_user.follow(@user)
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def destroy
    current_user.unfollow(@user.followed)
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  private
  def load_user_followed
    @user = User.find_by(id: params[:followed_id])
    return if @user

    flash[:danger] = t "not_exist"
    redirect_to :back
  end

  def load_relationship
    @user = Relationship.find_by(id: params[:id])
    return if @users

    flash[:danger] = t "not_exist"
    redirect_to :back
  end
end
