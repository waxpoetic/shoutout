Rails.application.routes.draw do
  devise_for :users
  resources :podcasts, except: [:new, :edit] do
    resources :episodes
  end
  root to: 'podcasts#index'
end
