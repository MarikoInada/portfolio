# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
user = User.create(
    name: "山田太郎",
    email: "123@example.com",
    password: "password123",
    password_confirmation: "password123"
)

hobbies = ["読書", "映画鑑賞", "ハイキング"]
hobbies.each do |hobby|
  user.hobbies.create(name: hobby)
end

emotions = ["楽しい", "疲れた", "嬉しい"]
emotions.each do |emotion|
  user.emotions.create(name: emotion, created_at: rand(1..30).days.ago)
end

messages = [
    { content: "こんにちは！今日は元気です。", sender: "user", created_at: 5.days.ago },
    { content: "リラックスできる時間をとってみてくださいね。", sender: "bot", created_at: 5.days.ago },
    { content: "昨日は疲れましたが、今日は大丈夫です。", sender: "bot", created_at: 3.days.ago },
  ]
  messages.each do |message|
    user.chat_messages.create(message)
  end
