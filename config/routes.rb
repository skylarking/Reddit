Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  root 'posts#index'

  get '/posts' => 'posts#index', as: :posts
  get '/posts/new'=> 'posts#new', as: :new_post
  get '/posts/:id' => 'posts#show', as: :post
  post '/posts' => 'posts#create'
  get '/posts/:id/edit' => 'posts#edit', as: :edit_post
  patch '/posts/:id' => 'posts#update'
  delete '/posts/:id' => 'posts#delete'

  post 'post/:id/comments' => 'posts#create_comment', as: :comments

  get 'posts/:id/upcount' => 'posts#upcount', as: :up_post
  patch 'posts/:id/upcount' => 'posts#upcount'
  get 'posts/:id/downcount' => 'posts#downcount', as: :down_post
  patch 'posts/:id/downcount' => 'posts#downcount'

  get '/users' => 'users#index', as: :users
  get '/users/:id' => 'users#show', as: :user

  resources :users do
    member do
      get :follow
      get :unfollow
      get :block
      get :unblock
    end
  end

  get '/about' => 'public#about', as: :about

  use_doorkeeper

  namespace :api do
    get 'posts' => 'posts#index'
    get 'posts/:id' => 'posts#show'
    post 'posts' => 'posts#create'
    patch 'posts/:id' => 'posts#update'
    put 'posts/:id' => 'posts#update'
    delete 'posts/:id' => 'posts#delete'
    post 'registrations' => 'registrations#create'
    post 'users' => 'registrations#create'
  end

end
