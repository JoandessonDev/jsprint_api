Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  # Rota para listar usuários
  resources :users, only: [ :index, :update, :destroy ]
  get "up" => "rails/health#show", as: :rails_health_check

  # root "posts#index"
end
