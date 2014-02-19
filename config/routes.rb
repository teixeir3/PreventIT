PreventIT::Application.routes.draw do
  get 'doctors/new', to: 'users#new_doctor'
  post 'doctors', to: 'users#create_doctor'

  resources :users, only: [:create, :new, :destroy, :show, :edit, :update] do
    resources :reminders
  end
  resource :session, only: [:create, :destroy, :new]

  root to: "sessions#new"
end
