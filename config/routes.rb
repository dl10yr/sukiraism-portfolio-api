Rails.application.routes.draw do
 namespace :api, defaults: { format: :json } do
    namespace :v1 do
      delete 'users', to: 'users#destroy'
      get 'users/:nickname', to: 'users#show'
      get 'user/currentuser', to: 'users#currentuser'
      get 'users/answered_suki_posts/:nickname', to: 'users#answered_suki_posts'
      get 'users/answered_kirai_posts/:nickname', to: 'users#answered_kirai_posts'
      # get 'users/not_interested_posts/:nickname', to: 'users#not_interested_posts'
      put 'users/update_privacy', to: 'users#update_privacy'

      get 'users/user_posts/:nickname', to: 'users#user_posts'
      get 'not_answered_posts', to: 'users#not_answered_posts'

      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
          omniauth_callbacks: 'api/v1/auth/omniauth_callbacks'
      }

      # resources :posts
      get 'posts', to: 'posts#index'
      post 'posts', to: 'posts#create'
      delete 'posts/:id', to: 'posts#destroy'
      get 'posts/:id', to: 'posts#show'
      get 'posts_suki', to: 'posts#suki_index'
      get 'posts_allcount', to: 'posts#all_count_index'
      get 'search', to: 'posts#search'

      post 'likes', to: 'likes#create'
      put 'likes/post/:post_id', to: 'likes#update'
      get 'likes/post/:post_id/user/:uid', to: 'likes#show'



    end
 end
 root 'home#about'
end