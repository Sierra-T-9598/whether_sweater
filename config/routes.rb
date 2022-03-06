Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resource :forecast, controller: 'forecasts', action: 'index'
      resources :backgrounds, controller: 'backgrounds', action: 'index'
    end
  end
end
