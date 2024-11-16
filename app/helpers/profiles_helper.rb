module ProfilesHelper
  def profile_content(profile, user)
    if profile.strength.present? || profile.interest.present? || profile.hobby.present?
      render 'shared/profile_full', profile: profile, user: user
    else
      content_tag(:p, 'プロフィールがまだ設定されていません。', class: 'text-gray-500')
    end
  end

  def display_profile_image(user)
    if user.image.present?
      image_tag user.image.url, alt: "#{user.name}のプロフィール画像", class: "rounded-full w-32 h-32 mx-auto"
    else
      content_tag :div, "画像未設定", class: "bg-gray-200 rounded-full w-32 h-32 mx-auto flex items-center justify-center"
    end
  end
end