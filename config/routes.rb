Rails.application.routes.draw do

  root :to => 'pages#home'
  devise_for :users,
              path: '',
              path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration'}, #this is to change the path ie., whenever they sign in will be /login if they signup it will be /registration
              controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}

  resources :users, only: [:show] #we want to create the path for showing user information
  resources :rooms, except: [:edit] do
    member do   #we will run every single action of specfic room id
      get 'listing'
      get 'pricing'
      get 'description'
      get 'photo_upload'
      get 'amenities'
      get 'location'
    end
    resources :photos, only: [:create, :destroy]
    resources :reservations, only: [:create]
  end

end
