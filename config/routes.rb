Rails.application.routes.draw do
 namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'user/currentuser', to: 'users#currentuser'
      get 'not_answered_posts', to: 'users#not_answered_posts'

      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
          omniauth_callbacks: 'api/v1/auth/omniauth_callbacks'
      }

      # resources :posts
      get 'posts', to: 'posts#index'
      get 'posts_suki', to: 'posts#suki_index'
      get 'posts_allcount', to: 'posts#all_count_index'

      post 'likes', to: 'likes#create'
      put 'likes/post/:post_id', to: 'likes#update'
      get 'likes/post/:post_id/user/:uid', to: 'likes#show'

    end
 end
 root 'home#about'
end