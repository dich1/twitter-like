class UsersController < ApplicationController
  before_action :require_user_signed_in, only: [:index, :show]
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.order(id: :desc).page(params[:page])
    counts(@user)
  end
end
