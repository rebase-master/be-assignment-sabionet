# frozen_string_literal: true

Rails.application.routes.draw do
  # devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { sessions: 'custom_sessions' }

  root to: 'static#dashboard'
  get 'people/:id', to: 'static#person', as: 'person'
  get 'users', to: 'users#index'
  post 'expenses', to: 'expenses#create'
  post 'settle/:user_id', to: 'expenses#settle'
end
