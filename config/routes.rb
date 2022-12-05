Rails.application.routes.draw do

  devise_for :users
  root to: "questions#index"

  resources :questions do
    resources :answers, shallow: true
  end 

  patch '/questions/:id/answers/:id', to: 'answers#update'
  
end
