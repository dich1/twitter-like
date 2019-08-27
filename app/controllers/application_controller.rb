class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private
  def require_user_signed_in
    unless user_signed_in?
      redirect_to new_user_session_url
    end
  end

  def counts(user)
    @count_tweets = user.tweets.count
  end
end
