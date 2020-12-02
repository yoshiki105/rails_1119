Rails.application.routes.draw do
  root 'top#index'
  get '/about', to: 'top#about', as: 'about'  # about_path使用可能

  1.upto(18) do |n|
    get "lesson/step#{n}(/:name)", to: "lesson#step#{n}"
  end

  # 普通のリソース
  resources :members do
    get 'search', on: :collection
    resources :entries, only: [:index] # ネストされたリソース
  end

  # 単数リソース
  resource :session, only: %i[create destroy]
  resource :account, only: %i[show edit update]
  resource :password, only: %i[show edit update]

  resources :articles
  resources :entries
end
