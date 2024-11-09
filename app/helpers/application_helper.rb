module ApplicationHelper
    def header_links
        safe_join([
        home_link,
        chat_link,
        login_or_logout_link
        ])
    end
    
    def home_link
        unless current_page?(root_path)
            link_to root_path, class: "btn btn-ghost rounded-btn" do
                tag.svg(xmlns: "http://www.w3.org/2000/svg", class: "h-5 w-5", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor") do
                    tag.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6")
                end
            end
        end
    end
    
    def chat_link
        return unless logged_in?
        link_to "Chat", user_chat_messages_path(current_user), class: "btn btn-ghost rounded-btn"
    end
    
    def login_or_logout_link
        if logged_in?
            link_to 'Logout', logout_path, data: { turbo_method: :delete }, class: 'btn btn-secondary'
        else
            link_to 'Login with Google', auth_at_provider_path(provider: :google), class: 'btn btn-primary'
        end
    end
      
    def my_prof_link
        return unless logged_in?
        link_to "Prof", user_profile_path(current_user), class: "dropdown-item"
    end

    def my_hobbies_link
        return unless logged_in?
        link_to "hobbies", user_hobbies_path(current_user), class: "dropdown-item"
    end
end
