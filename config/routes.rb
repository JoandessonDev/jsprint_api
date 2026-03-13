Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  # USERS
  resources :users, only: [ :index, :update, :destroy ]
  get "up" => "rails/health#show", as: :rails_health_check

  # WORKSPACES
  resources :workspaces

  # PROJECTS
  resources :projects

  # COLUMNS
  resources :columns, only: [ :create, :update, :destroy ]
end
