Rails.application.routes.draw do
  devise_for :users

  resources :profile, path: 'users/profile'

  resources :posts, path: 'users/posts' do
    patch 'comment/new', to: 'posts#create_comment'
  end



  root to: 'home#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
