Rails.application.routes.draw do

  # 顧客用
  # URL /members/sign_in ...
  devise_for :members,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do

    root :to =>"homes#top"

    get "about" => "homes#about"
    # get "home/about"=>"homes#about"

    get 'members/unsubscribe' => 'members#unsubscribe', as: 'unsubscribe'
    patch 'members/withdraw' => 'members#withdraw', as: 'withdraw'
    resources :members, only: [:index,:show,:edit,:update] do
      resource :relationships, only: [:create, :destroy]
    	get 'followings' => 'relationships#followings', as: 'followings'
    	get 'followers' => 'relationships#followers', as: 'followers'
  end

    resources :books, only: [:new, :index, :show, :edit, :create, :destroy, :update] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end

    get '/search', to: 'searches#search'

  end

  namespace :admin do
    resources :member, only: [:index, :show, :edit, :update]

    get '/' => 'homes#top', as: 'top'

    resources :books, only: [:destroy] do
      resources :post_comments, only: [:destroy]
    end

    resources :categories, only: [:index, :create, :edit, :update]

    resources :genres, only: [:index, :create, :edit, :update]

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
