Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'main/index'
  root 'main#index'
  get 'students/dashboard/index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }
  
  scope module: :teacher do
    resources :courses do
      resources :topics
    end
    resources :subscribers
  end
  
  scope module: :student do
    resources :dashboard 
    resources :purchases
    resources :subscriptions
    post "/checkout/create", to: "checkout#create"
    get '/checkout/success', to: "checkout#success"
    get '/checkout/cancel', to: "checkout#cancel"
    get 'payment/payment_successful', to: "payments#payment_successful"
    get 'payment/payment_cancel', to: "payments#payment_cancel"
  end
end
