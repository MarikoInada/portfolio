class ChatMessagesController < ApplicationController
    before_action :set_user

  def index
    @chat_messages = @user.chat_messages.order(created_at: :asc)
    @new_message = ChatMessage.new
  end

  def create
    # ユーザーのメッセージを保存
    @chat_message = @user.chat_messages.build(chat_message_params.merge(sender: "user"))

    if @chat_message.save
      # ボットからの返信を作成（ここでは仮の応答）
      bot_reply = generate_bot_reply(@chat_message.content)
      @user.chat_messages.create(content: bot_reply, sender: "bot")

      redirect_to user_chat_messages_path(@user)
    else
      @chat_messages = @user.chat_messages.order(created_at: :asc)
      render :index
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def chat_message_params
    params.require(:chat_message).permit(:content)
  end

  def generate_bot_reply(user_message)
    # ボットの応答を生成するロジック（仮実装）
    "You said: #{user_message}"
  end
end
