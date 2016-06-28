Rails.application.routes.draw do
  root to: 'prototipos#index'

  resources :prototipos
  post 'prototipos/id/comentarios', controller: 'comentarios', action: 'create'
  delete 'prototipos/id/comentarios/:id',
         controller: 'comentarios', action: 'destroy'

  post 'prototipos/id/configs_prototipos',
       controller: 'configs_prototipos', action: 'create'
  delete 'prototipos/id/configs_prototipos/:id',
         controller: 'configs_prototipos', action: 'destroy'
  put 'prototipos/id/configs_prototipos',
      controller: 'configs_prototipos', action: 'update'
  # resources :comentarios, only: [:create, :destroy]
  # resources :configs_prototipos, only: [:create, :destroy, :update]
end
