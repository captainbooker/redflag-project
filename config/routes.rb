Rails.application.routes.draw do
  resources :tasks
  root to: 'projects#index'
  devise_for :users, controllers: { registrations: 'registrations' }
  
  namespace :api do
    namespace :v1 do
      devise_for :users, controllers: {
        sessions: 'api/v1/sessions',
        registrations: 'api/v1/registrations'
      }
    end
  end

  resources :projects do
    resources :tasks, only: [:index, :new, :create, :edit, :update, :destroy]
  end

end
