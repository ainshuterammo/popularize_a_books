Rails.application.routes.draw do

  devise_scope :member do
    post 'members/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

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

    get "about", to: "homes#about"
    # get "home/about"=>"homes#about"

    get 'members/unsubscribe', to: 'members#unsubscribe', as: 'unsubscribe'
    patch 'members/withdraw', to: 'members#withdraw', as: 'withdraw'
    resources :members, only: [:index,:show,:edit,:update] do
      resource :relationships, only: [:create, :destroy]
    	get 'followings', to: 'relationships#followings', as: 'followings'
    	get 'followers', to: 'relationships#followers', as: 'followers'
    	member do
        get :favorites
      end
    end

    get 'books/search'
    get 'books/selection'
    resources :books, only: [:new, :index, :show, :edit, :create, :destroy, :update] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end

    get '/search', to: 'searches#search'

  end

  namespace :admin do
    resources :members, only: [:index, :show, :edit, :update]

    get '/', to: 'homes#top', as: 'top'

    resources :books, only: [:index, :destroy] do
      resources :post_comments, only: [:destroy]
    end

    resources :genres, only: [:index, :create, :edit, :update]

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
