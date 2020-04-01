Rails.application.routes.draw do
  root to: redirect('/users/sign_in')

  devise_for :users

  namespace :private_panel do
    root 'homes#index'

    resources :homes, only: :index
  end
end
