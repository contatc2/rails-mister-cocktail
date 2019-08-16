Rails.application.routes.draw do
  resources :cocktails, only: %i[index show new create update] do
    resources :doses, only: %i[new create]
  end
  resources :images, only: :destroy
  delete 'doses/:id', to: 'doses#destroy', as: 'dose'
  get root to: 'cocktails#index'
  get 'saved', to: 'cocktails#saved'
end
