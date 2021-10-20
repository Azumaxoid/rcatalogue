Rails.application.routes.draw do
  get '/health' => 'health#index'
  get '/catalogue' => 'catalogue#index'
  get '/catalogue/size' => 'catalogue#size'
  get '/catalogue/:sock_id' => 'catalogue#item'
  get '/tags' => 'tags#index'
  resources :catalogue, only: [:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
