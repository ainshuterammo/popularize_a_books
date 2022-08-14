Rails.application.routes.draw do

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :members, only: [:index, :show, :edit, :update]
    get '/', to: 'homes#top', as: 'top'
    resources :books, only: [:show, :index, :destroy] do
      resources :post_comments, only: [:destroy]
    end
    resources :genres, only: [:index, :create, :edit, :update]
  end

  # 顧客用
  devise_for :members,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :member do
    post 'members/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    root :to =>"homes#top"

    get "home/about"=>"homes#about", as: 'about'

    get 'members/unsubscribe', to: 'members#unsubscribe', as: 'confirm_unsubscribe'
    patch 'members/withdraw', to: 'members#withdraw', as: 'withdraw_member'

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

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
