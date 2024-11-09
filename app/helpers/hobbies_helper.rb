module HobbiesHelper
    def hobby_display_content(hobby)
        if hobby.image.present?
          image_tag(hobby.image.url, class: "mask mask-heart h-32 w-32")
        elsif hobby.name.present?
          content_tag(:div, hobby.name, class: "mask mask-heart bg-primary flex items-center justify-center text-white font-bold h-32 w-32")
        else
          nil
        end
    end
end