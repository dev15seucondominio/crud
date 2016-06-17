Rails.application.routes.draw do
  root to: 'prototipos#index'

  resources :prototipos do
    collection do
      post :comentarios, to: 'prototipos#comentarios_create'
      delete :comentarios, to: 'prototipos#comentarios_destroy'
    end
  end
end
