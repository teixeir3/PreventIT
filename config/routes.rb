PreventIT::Application.routes.draw do
  get "password_resets/new"

  # get 'doctors/new', to: 'users#new_doctor'
#   post 'doctors', to: 'users#create_doctor'

  resources :doctors

  get '/search' => 'pages#new', as: 'new_search'
  get '/search/patients' => 'pages#search_patients', as: 'patient_search'
  get '/search/diagnoses' => 'pages#search_diagnoses', as: 'diagnoses_search'
  get '/search/medications' => 'pages#search_medications', as: 'medications_search'
  get '/search/full_medications' => 'pages#search_full_medications', as: 'full_medications_search'
  # get '/med_init_selection' => 'pages#init_selection', as: 'medication_init'
  get 'alerts/completed' => 'alerts#completed', as: 'alerts_completed'

  resources :alerts, only: [:index, :edit, :update, :show]
  resources :appointment_types

  put 'alert/:id/complete' => 'alerts#mark_complete', as: 'alert_complete'

  get 'users/:user_id/reminders/completed' => 'reminders#completed', as: 'reminders_completed'
  get 'users/:user_id/reminders/upcoming' => 'reminders#upcoming', as: 'reminders_upcoming'
  
  
  resources :users, only: [:create, :new, :destroy, :show, :edit, :update] do
    resources :reminders
    resources :diagnoses
    resources :appointments
    get 'add_diagnosis' => 'diagnoses#add_diagnosis', as: 'add_diagnosis'
    get :activate, on: :collection
    get :password_reset, on: :collection
    put :password_update, on: :collection
    resources :medications
    resources :symptoms do
      resources :reminders, controller: :reminders, only: [:new, :create, :index]
    end
  end
  
  resource :session, only: [:create, :destroy, :new]
  resources :password_resets, only: [:new, :edit, :update, :create]
  get '/auth/google_oauth2/callback' => 'sessions#create'

  root to: "sessions#new"
end
