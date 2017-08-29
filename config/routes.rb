Rails.application.routes.draw do
  root :to => 'pages#home'
  devise_for :users,
              path: '',
              path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration'}, #this is to change the path ie., whenever they sign in will be /login if they signup it will be /registration
              controllers: {omniauth_callbacks: 'omniauth_callbacks'}

  resources :users, only: [:show] #we want to create the path for showing user information

end
