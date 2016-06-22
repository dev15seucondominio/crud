Rails.application.routes.draw do
  root to: 'prototipos#index'

  resources :prototipos do
    collection do
      post :comentarios, to: 'prototipos#comentarios_create'
      delete :comentarios, to: 'prototipos#comentarios_destroy'
    end
  end
  resources :configs_prototipos, only: [:create, :destroy, :update]
  put '/configs_prototipos.json', to: 'configs_prototipos#update'
end
