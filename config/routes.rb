Rails.application.routes.draw do

  root "top#index"

  get "login" => "top#login", as: "login"
  post "login" => "sessions#login"

  resources :events, except: [:new] do
    member do
      get :buy
      post "buy" => "events#buy_create", as: "buy_create"
      get "buy_result" => "events#result", as: "result"
      patch :like, :unlike
    end
    collection do
      get :new_1
      get :new_2
    end
  end

  resources :members

  resource :account, only: [:new , :create]

  resource :my do
    get :info
    get :ticket_his
    get :tickets
    get :tickets_stat
    get :event_his
    get :bkm
  end

  resource :admin do
    get "login" => "admin#login", as: "login"
    post "login" => "sessions#admin_login"
    get "top"
    resources :members, except: [:create, :new]
    resources :events 
    resources :places
  end

end
