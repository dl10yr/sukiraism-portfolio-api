Rails.application.routes.draw do
 namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'user/currentuser', to: 'users#currentuser'

      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
          omniauth_callbacks: 'api/v1/auth/omniauth_callbacks'
      }
      
      resources :posts
    end
 end
 root 'home#about'
end