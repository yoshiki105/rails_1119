Rails.application.routes.draw do
  root "top#index"
  get "/about", to: "top#about", as: "about"  # about_path使用可能

  1.upto(18) do |n|
    get "lesson/step#{n}(/:name)", to: "lesson#step#{n}"
  end
end
