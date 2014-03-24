PreventIT::Application.routes.draw do
  # get 'doctors/new', to: 'users#new_doctor'
#   post 'doctors', to: 'users#create_doctor'

  resources :doctors

  get '/search' => 'pages#new', as: 'new_search'
  get '/search/patients' => 'pages#search_patients', as: 'patient_search'
  get '/search/diagnoses' => 'pages#search_diagnoses', as: 'diagnoses_search'
  get '/search/medications' => 'pages#search_medications', as: 'medications_search'
  # get '/med_init_selection' => 'pages#init_selection', as: 'medication_init'
  get 'alerts/completed' => 'alerts#completed', as: 'alerts_completed'

  resources :alerts, only: [:index, :edit, :update, :show]
  resources :appointment_types

  put 'alert/:id/complete' => 'alerts#mark_complete', as: 'alert_complete'

  get 'users/:user_id/reminders/completed' => 'reminders#completed', as: 'reminders_completed'

  resources :users, only: [:create, :new, :destroy, :show, :edit, :update] do
    resources :reminders
    resources :diagnoses
    resources :appointments
    get 'add_diagnosis' => 'diagnoses#add_diagnosis', as: 'add_diagnosis'
    get :activate, on: :collection
    
    resources :medications
  end
  resource :session, only: [:create, :destroy, :new]

  get '/auth/google_oauth2/callback' => 'sessions#create'

  root to: "sessions#new"
end
