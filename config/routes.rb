Rails.application.routes.draw do  
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  resources :users do
    resources :diary_entries # ユーザーに紐づく日記エントリ
    resources :answers # ユーザーに紐づく回答
    resource :profile, only: [:show, :edit, :update]
    resources :chat_messages, only: [:index, :create]
    resources :hobbies, only: [:index, :new, :edit, :create, :destroy]
  end

  resources :emotions do
    resources :emotion_questions # 感情に紐づく質問
  end
  root 'static_pages#top'
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" 
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  resources :tasks

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  #root "tasks#index"
end
