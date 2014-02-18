PreventIT::Application.routes.draw do
  resources :users, only: [:create, :new, :destroy, :show] do
    resources :reminders
  end
  resource :session, only: [:create, :destroy, :new]

  root to: "sessions#new"
end