class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :require_login
  helper_method :logged_in?, :current_user

  private

  def require_login
    unless logged_in?
      redirect_to auth_at_provider_path(provider: :google), alert: "ログインが必要です"
    end
  end

  # ログイン状態を確認するメソッド
  def logged_in?
    !!current_user
  end

  # 現在のユーザーを取得するメソッド
  def current_user
    Rails.logger.info "Session user_id: #{session[:user_id]}" # ログにセッションIDを出力
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    Rails.logger.info "Current user: #{@current_user.inspect}" # ログに現在のユーザーを出力
    @current_user
  end
end
