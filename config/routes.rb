Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  resources :posts
  resources :projects
  resources :contacts, only: [:new, :create]

  get '*path' => redirect('/')
end
