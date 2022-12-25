Rails.application.routes.draw do

  devise_for :users
  root to: "questions#index"

  resources :questions do
    resources :answers, shallow: true 
  end 

  patch '/questions/:id/answers/:id', to: 'answers#update'
  
  get 'author_answers', to: 'answers#my_answers'

end
