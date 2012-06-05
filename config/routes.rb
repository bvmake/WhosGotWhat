WhosGotWhat::Application.routes.draw do

  match "/dashboard" => "home#dashboard"

  resources :users, :only => [:show]

  match "/auth/:provider/callback" => "sessions#create"
  match "/auth/failure", to: "sessions#failure"

  match "/on_waitlist"    => "home#static"
  root :to => 'home#landing'

end
