Rails.application.routes.draw do

  devise_for :users
  root to: "questions#index"

  resources :questions do
    resources :answers, shallow: true
  end 

  resources :answers

  delete "files/:id/purge", to: "files#purge", as: "purge_file"
  

  patch '/questions/:id/answers/:id', to: 'answers#update'
  
  get 'author_answers', to: 'answers#my_answers'
  get 'my_rewards', to: 'rewards#index'
  get 'answer_vote', to: 'answers#vote'

  resources :links, only: :destroy
  resources :rewards, only: :index
  post 'like', to: 'likes#like', as: 'like'

  mount ActionCable.server => '/cable'

end
