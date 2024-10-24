class OauthsController < ApplicationController
  skip_before_action :require_login, only: [:oauth, :callback]

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = params[:provider] || "google"
    if (@user = login_from(provider))
      session[:user_id] = @user.id
      Rails.logger.info "User logged in: #{@user.inspect}"
      redirect_to root_path, notice:"#{provider.titleize}アカウントでログインしました"
    else
      begin
        signup_and_login(provider)
        session[:user_id] = @user.id
        Rails.logger.info "New user signed up: #{@user.inspect}"
        redirect_to root_path, notice:"#{provider.titleize}アカウントでログインしました"
      rescue => e
        Rails.logger.error "Signup and login failed: #{e.message}"
        redirect_to tasks_path, alert:"#{provider.titleize}アカウントでのログインに失敗しました"
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end

  def signup_and_login(provider)
    @user = create_from(provider)
    reset_session
    auto_login(@user)
  end
end
