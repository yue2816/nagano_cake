Rails.application.routes.draw do
  devise_for :customers
  devise_for :admins

  # 会員側のルーティング設定
  scope module: :public do
    root to: "homes#top"
    get 'about' => 'homes#about'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
