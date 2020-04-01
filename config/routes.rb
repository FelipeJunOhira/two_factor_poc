Rails.application.routes.draw do
  root to: redirect('/users/sign_in')

  devise_for :users

  namespace :private_panel do
    root 'homes#index'

    resources :homes, only: :index
    resources :settings, only: :index
    resource :qr_code, only: :show

    namespace :settings do
      resource :one_time_password, only: [:new, :create, :destroy] do
        get :intro
      end
    end
  end
end
