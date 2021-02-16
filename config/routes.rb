Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #get '/checks', to: 'checks#index'
  resource :checks
  post '/admin/attendences', to: 'admin/attendences#index'
  post '/admin/absences', to: 'admin/absences#index'
end
