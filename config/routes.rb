Rails.application.routes.draw do
  get 'cocktails/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'cocktails#index'
  get 'cocktails', to: 'cocktails#create'
end
