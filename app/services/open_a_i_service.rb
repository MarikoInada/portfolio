# app/services/openai_service.rb
class OpenAIService
  def initialize(user)
    @user = user
    @client = OpenAI::Client.new
  end

  def generate_response(user_input)
    recommendation = user_has_hobbies? ? recommendation_from_user_hobbies : recommendation_from_emotions_and_recent_messages
    prompt = generate_prompt(user_input, recommendation)

    response = @client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [
          { role: "system", content: "あなたはユーザーの気持ちに寄り添って、気軽なアドバイスや提案をするメンタルケアアシスタントです。フランクな言葉で応答してください。" },
          { role: "user", content: prompt }
        ],
        max_tokens: 90,
        temperature: 0.5
      }
    )
    
    response["choices"].first.dig("message", "content").strip
    
  rescue => e
    Rails.logger.error("OpenAI API error: #{e.message}")
    "ごめんなさい、現在サポートにお応えできません。"
  end

  private

  def user_has_hobbies?
    @user.hobbies.exists?
  end

  # メンタルケアのメッセージに趣味の提案を組み込むプロンプトを構築
  def generate_prompt(user_input, recommendation)
    <<~PROMPT
      ユーザーの趣味: #{user_hobbies}
      最近の感情: #{recent_emotions}

      ユーザー: "#{user_input}"
      あなた: #{recommendation}
    PROMPT
  end

  def user_hobbies
    @user.hobbies.pluck(:name).join(", ")
  end

  def recent_emotions
    @user.emotions.order(created_at: :desc).limit(3).pluck(:name).join(", ")
  end

  def recent_messages
    @user.chat_messages.order(created_at: :desc).limit(5).pluck(:content).join("\n")
  end

  # 趣味データに基づいた提案を生成
  def recommendation_from_user_hobbies
    hobbies = @user.hobbies.pluck(:name)
    "最近#{hobbies.sample}をしてみませんか？" if hobbies.present?
  end

  def recommendation_from_emotions_and_recent_messages
    recent_emotions = @user.emotions.order(created_at: :desc).limit(3).pluck(:name)
    recent_messages = @user.chat_messages.order(created_at: :desc).limit(3).pluck(:content)

    if recent_emotions.present?
      "#{recent_emotions.join(", ")}と感じることが多いんだね。気分転換を試してね。"
    elsif recent_messages.present?
      "最近、#{recent_messages.first}と言っていたね。少しリラックスしよう。"
    else
      "リラックスできることを試してみよう。"
    end
  end
end