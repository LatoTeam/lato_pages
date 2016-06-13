LatoPages::Engine.routes.draw do

  root 'back/pages#index'

  resources :pages, module: 'back'

  scope '/api/v1/' do
    get 'fields', to: 'api/v1/fields#index'
    get 'fields/:page', to: 'api/v1/fields#index'
    get 'fields/:page/:lang', to: 'api/v1/fields#index'

    get 'field/:name/:page', to: 'api/v1/fields#show'
    get 'field/:name/:page/:lang', to: 'api/v1/fields#show'
  end

end
