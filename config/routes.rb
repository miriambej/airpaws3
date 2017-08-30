Rails.application.routes.draw do
  get 'room/index'

  get 'room/new'

  get 'room/create'

  get 'room/listing'

  get 'room/pricing'

  get 'room/description'

  get 'room/photo_upload'

  get 'room/amenities'

  get 'room/location'

  get 'room/update'

  root :to => 'pages#home'
  devise_for :users,
              path: '',
              path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration'}, #this is to change the path ie., whenever they sign in will be /login if they signup it will be /registration
              controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}

  resources :users, only: [:show] #we want to create the path for showing user information

end
