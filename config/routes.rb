PreventIT::Application.routes.draw do
  # get 'doctors/new', to: 'users#new_doctor'
#   post 'doctors', to: 'users#create_doctor'

  resources :doctors

  get '/search' => 'pages#new', as: 'new_search'
  get '/search/patients' => 'pages#search_patients', as: 'patient_search'
  get '/search/diagnoses' => 'pages#search_diagnoses', as: 'diagnosis_search'

  get 'alerts/completed' => 'alerts#completed', as: 'alerts_completed'

  resources :alerts, only: [:index, :edit, :update, :show]


  put 'alert/:id/complete' => 'alerts#mark_complete', as: 'alert_complete'

  get 'users/:user_id/reminders/completed' => 'reminders#completed', as: 'reminders_completed'

  resources :users, only: [:create, :new, :destroy, :show, :edit, :update] do
    resources :reminders
    resources :diagnoses
  end
  resource :session, only: [:create, :destroy, :new]

  root to: "sessions#new"
end
