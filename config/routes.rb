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

  resources :profiles, only: [:show], param: :uuid
end
