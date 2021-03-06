Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index, :show]

  resources :podcasts, except: [:edit] do
    resources :episodes, except: [:index, :edit]

    member do
      get :deploy
    end
  end

  root to: 'podcasts#index'
end
