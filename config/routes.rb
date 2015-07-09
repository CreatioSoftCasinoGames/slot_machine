require 'sidekiq/web'
Rails.application.routes.draw do

  resources :game_versions
  mount Sidekiq::Web => '/sidekiq'

  resources :versions do
    collection do
      put :update_users
    end
  end

  resources :jackpots

  resources :tournaments

  resources :graphics

  resources :mini_games

  resources :client_bugs

  resources :machines

  resources :themes

  resources :assets, path: "capitals", controller: :assets

  resources :images

  resources :pay_lines

  resources :reels

  resources :pay_tables

  resources :stamps

  resources :math_models do
    member do
      get :pay_tables
      get :pay_lines
      get :reels
    end
  end

  get "utility/show_api_key", to: "utility#show_api_key", as: "show_api_key"
  post "utility/generate_api_key", to: "utility#generate_api_key", as: "generate_api_key"
  resources :utility do
    collection do
      get :sync_data
      get :sync_tournament
      get :delete_data
    end
  end

  resources :machines
  devise_for :users

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  root 'welcome#index'
  get '/privacy' => "welcome#privacy"
  get '/terms' => "welcome#terms"

  namespace :api do
    namespace :v1 do
      get "/versions" => "welcome#versions"
      resources :machines
      resources :math_models
      resources :friend_requests
      resources :gift_requests
      resources :tournament_users
      resources :client_bugs
      resources :schedule_maintenances do 
        collection do
          post :sm
        end
      end
      resources :distributable_jackpots do
        member do
          put :jackpot_amount
        end
      end
      resources :assets
      resources :users
      resources :mini_games
      resources :sessions, :only => [:create, :destroy]
      resources :users do
        member do
          put :log_spin
          get :friend_request_sent
          get :my_friend_requests
          get :my_friends
          delete :delete_friend
          get :sent_gift
          get :received_gift
          get :get_reward
          get :winner_jackpot
          get :view_jackpot_winner
        end
      end
      resources :themes do
        get :asset_versions, on: :member
      end
      resources :machines do
        member do
          get :assets
        end
      end
      resources :math_models do
        member do
          get :asset_versions
        end
      end
      resources :mini_games do
        member do
          get :asset_versions
        end
      end
    end
  end

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
