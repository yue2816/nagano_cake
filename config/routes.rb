Rails.application.routes.draw do
  # 顧客側deviseのルーティング
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用deviseのルーティング
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # 顧客側のルーティング設定
  scope module: :public do
    root to: "homes#top"
    get 'about' => 'homes#about'
    get 'customers/my_page' => 'customers#show'
    get 'customers/information/edit' => 'customers#edit'
    patch 'customers/information' => 'customers#update'
    get 'customers/check' => 'customers#check'
    patch 'customers/withdrawl' => 'customers#withdrawl', as: 'withdrawal'
  end

  # 管理者側のルーティング設定
  namespace :admin do
    resources :items, only: [:new, :index, :create, :show, :edit, :update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
