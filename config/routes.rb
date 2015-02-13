Rails.application.routes.draw do
  root to: "home#index"

  post '/contact_us',            to: 'messages#contact_us',            as: 'contact_us'
  post '/mailgun_receive_email', to: 'messages#mailgun_receive_email', as: 'mailgun_receive_email'

  # Client Methods
  devise_for :users, :controllers => { :registrations => "users/registrations", :sessions => "users/sessions" }
  resources :users do
    resources :jobs, only: [:new, :create, :show, :update, :index]
  end

  # Proofreader methods
  resources :users, only: [:index]
  resources :messages, only: [:index]
  get   "/users/:id/manage",            to: 'users#manage',            as: "manage_user"
  patch "/users/:id/management_update", to: 'users#management_update', as: "user_management_update"

  get   'all_jobs', to: 'jobs#all_jobs', as: 'all_jobs'
  get   'jobs/:id/manage',         to: 'jobs#manage', as: 'job_manage'
  patch 'jobs/:id/manage_update',  to: 'jobs#manage_update'
  post  'tasks/:id/start',         to: 'tasks#create_timer'
  patch 'timers/:id/end',          to: 'timers#end_timer', as: 'end_timer'
  patch 'tasks/:id/upload',        to: 'tasks#upload_files' # Is this a post route, Only file uploaded as sub element to task
  patch 'tasks/:id/mark_complete', to: 'tasks#mark_complete'
  patch 'jobs/:id/proofreader_message', to: 'jobs#send_client_email'

  # resources :charges, :only => [:new]
  # post '/buy_credits', to: 'charges#buy_credits', as: 'buy_credits'
  
end