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
      get 'preload'
      get 'preview'
    end
    resources :photos, only: [:create, :destroy]
    resources :reservations, only: [:create] #we put it here so when we do the reservations it falls to the room id
  end

  resources :guest_reviews, only: [:create, :destroy]
  resources :host_reviews, only: [:create, :destroy]
  # if you type /your_pet_trips it will run the reservations controller and your_pet_trips action.
  get '/your_pet_trips' => 'reservations#your_pet_trips'
  get '/your_reservations' => 'reservations#your_reservations'

  get 'search' => 'pages#search'

  #--------------------
  # 'dashboard' you can name it anything you want
  get 'dashboard' => 'dashboards#index'

end
