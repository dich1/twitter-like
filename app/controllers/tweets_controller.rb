class TweetsController < ApplicationController
  before_action :require_user_signed_in
  before_action :correct_user, only: [:destroy]

  def index
    if user_signed_in?
      @tweet = current_user.tweets.build
      @tweets = current_user.tweets.order(id: :desc).page(params[:page])
    end
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @tweets = current_user.tweets.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'tweets/index'
    end
  end

  def destroy
    @tweet.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private
  def tweet_params
    params.require(:tweet).permit(:content)
  end

  def correct_user
    @tweet = current_user.tweets.find_by(id: params[:id])
    unless @tweet
      redirect_to root_url
    end
  end
end
