Rails.application.routes.draw do
  root "top#index"
  get "/about", to: "top#about", as: "about"  # about_path使用可能

  1.upto(18) do |n|
    get "lesson/step#{n}(/:name)", to: "lesson#step#{n}"
  end

  # 普通のリソース
  resources :members do
    get "search", on: :collection
  end

  # 単数リソース
  resource :session, only: [:create, :destroy]
  resource :account, only: [:show, :edit, :update]
  resource :password, only: [:show, :edit, :update]
end
