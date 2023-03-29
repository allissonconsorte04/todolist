Rails.application.routes.draw do
  resources :users
  resources :activities, param: :code

  resources :sessions, only: %i[new create destroy] do
    member do
      get :enter_token
      post :verify_token
    end
  end

  resources :tokens, only: [] do
    collection do
      post :verify
    end
  end

  root to: 'sessions#new'

  resources :profiles, only: [:show], param: :uuid

  get '/activities/:id', to: 'activities#show', format: :json
end
