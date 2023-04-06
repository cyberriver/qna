Rails.application.routes.draw do

  devise_for :users, controllers: {omniauth_callbacks: 'oauth_callbacks'}


  root to: "questions#index"

  resources :questions do
    resources :answers, shallow: true
    resources :comments, shallow: true      
  end 
  
  resources :comments

  resources :answers 
  resources :authorizations

  resources :authorizations, only: [:create] do
    member do
      get :confirm_email
    end
  end

  patch 'send_email_verification', to: 'authorizations#send_email'

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
