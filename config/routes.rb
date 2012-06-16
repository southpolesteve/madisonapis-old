Madisonapis::Application.routes.draw do

  resources :parks, :only => [:show, :index]
  resources :properties, :only => [:show, :index]
  resources :fires, :only => [:show, :index]
  
  root :to => "home#index"
end
