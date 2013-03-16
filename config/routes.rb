TimeClock::Application.routes.draw do
  root to: 'punches#index'

  resources :punches, only: [:index, :create, :destroy]
end
