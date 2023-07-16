require 'sidekiq/web'

Rails.application.routes.draw do
  resources :subscriptions
  authenticate :user, lambda { |u| u.admin?} do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :subscriptions, only: %i[create destroy], shallow: true

  use_doorkeeper do
    skip_controllers :authorizations, :applications,
                    :authorized_applications
  end
  
  devise_for :users, controllers: {omniauth_callbacks: 'oauth_callbacks'},  path_names: { sign_in: :login, sign_out: :logout}
  root to: "questions#index"
  resources :questions do
    resources :answers, shallow: true
    resources :comments, shallow: true
    resources :subscriptions, only: %i[create destroy], shallow: true
  end 
  
  get '/search_questions', to: 'search#search_questions', as: 'search_questions'

  namespace :api do
    namespace :v1 do
      resources :answers    
      resources :profiles, only: [:index] do
        get :me, on: :collection
      end
      
      resources :questions, only: [:index, :show, :create, :update, :destroy] do
        resources :answers, shallow: true
        resources :comments, shallow: true     
      end
    end
  end
  
  resources :comments
  resources :answers 
  resources :authorizations, only: [:create] do
    member do
      get :confirm_email
    end
  end

  patch 'send_email', to: 'authorizations#send_email'
  delete "files/:id/purge", to: "files#purge", as: "purge_file"
  patch '/questions/:id/answers/:id', to: 'answers#update'
  get 'make_comment', to: 'comments#new'  
  get 'author_answers', to: 'answers#my_answers'
  get 'my_rewards', to: 'rewards#index'
  get 'answer_vote', to: 'answers#vote'

  resources :links, only: :destroy
  resources :rewards, only: :index 
  post 'like', to: 'likes#like', as: 'like'
  mount ActionCable.server => '/cable'

end
