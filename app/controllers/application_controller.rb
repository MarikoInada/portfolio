class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :require_login
  helper_method :logged_in?, :current_user

  private
  # ログイン状態を確認するメソッド
  def logged_in?
    logged_in_status = !!current_user
    #Rails.logger.info "Logged in?: #{logged_in_status}"  # ログ出力
    logged_in_status

  end

  # 現在のユーザーを取得するメソッド
  def current_user
    #Rails.logger.info "Session user_id: #{session[:user_id]}" # ログにセッションIDを出力
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    #Rails.logger.info "Current user: #{@current_user.inspect}" # ログに現在のユーザーを出力
  end
end
