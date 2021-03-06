Echowaves::Application.routes.draw do

  devise_for :users

  resources :users, :only => [:index, :show] do
    resources :followerships, :only => [:create, :destroy]
  end

  resources :convos, :only => [:index, :show, :new, :create] do
    # nested message, essential to support restful resources for messages
    resources :messages, :only => [:index, :show, :create]
  end

  resources :visits, :only => [:index]
  resources :updates, :only => [:index]
  resources :invitations, :only => [:index, :new, :create, :destroy] do
    put :accept
  end

  root :to => "welcome#index"
  match '/welcome', :to => 'welcome#index', :as => :welcome

  resource :socket, :only => [:subscribe, :unsubscribe] do
    member do
      post :subscribe
      post :unsubscribe
    end
  end

  resources :subscriptions, :only => [:index, :create, :destroy ]


end
