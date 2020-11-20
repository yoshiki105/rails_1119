Rails.application.routes.draw do
  root "top#index"
  get "/about", to: "top#about", as: "about"  # about_path使用可能
end
