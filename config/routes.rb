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
  get 'answer_vote', to: 'answers#vote'

end
