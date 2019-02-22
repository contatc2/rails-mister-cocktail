Rails.application.routes.draw do
  resources :cocktails, only: %i[index show new create] do
    resources :doses, only: %i[new create]
  end
  delete 'doses/:id', to: 'doses#destroy', as: 'dose'
  get root to: 'cocktails#index'
end
