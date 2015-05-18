Rails.application.routes.draw do
  resources :episodes
  resources :podcasts
  devise_for :users
  #root to: 'podcasts#index'
end
