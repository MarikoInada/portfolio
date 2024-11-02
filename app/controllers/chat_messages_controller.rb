class ChatMessagesController < ApplicationController
  require_dependency 'open_a_i_service'
  before_action :set_user

  def index
    @chat_messages = @user.chat_messages.includes(:user).order(created_at: :desc)
    @new_message = ChatMessage.new
  end

  def start_new_chat
    clear_messages
    redirect_to user_chat_messages_path(@user)
  end

  def create
    if save_user_message && save_bot_reply
      redirect_to user_chat_messages_path(@user)
    else
      @chat_messages = @user.chat_messages.order(created_at: :desc)
      render :index
    end
  end

  private

  # ユーザーメッセージの保存
  def save_user_message
    @user.chat_messages.create(chat_message_params.merge(sender: "user"))
  end

  # ボットの応答を保存
  def save_bot_reply
    bot_reply = generate_bot_reply(@user.chat_messages.last.content)
    @user.chat_messages.create(content: bot_reply, sender: "bot")
  end

  # OpenAIServiceでボットからの応答を生成
  def generate_bot_reply(user_message)
    OpenAIService.new(@user).generate_response(user_message)
  end

  # ユーザーの設定
  def set_user
    @user = User.find(params[:user_id])
  end

  # チャットメッセージのクリア
  def clear_messages
    @user.chat_messages.destroy_all
  end

  # メッセージパラメータの許可
  def chat_message_params
    params.require(:chat_message).permit(:content)
  end
end
