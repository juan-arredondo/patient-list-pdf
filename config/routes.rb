Rails.application.routes.draw do
  root 'patients#index'
  # get 'patients/show'
  resources :patients, only: [:show, :index]
end
