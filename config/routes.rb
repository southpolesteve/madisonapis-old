Madisonapis::Application.routes.draw do
  resources :parks, :only => [:show, :index]

  root :to => "home#index"
end
