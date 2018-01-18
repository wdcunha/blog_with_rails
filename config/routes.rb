Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match "/delayed_job", to: DelayedJobWeb, anchor: false, via: [:get, :post]

  namespace :admin do
    resources :dashboard, only: [:index]
  end


  # resource :posts #, only: [:new, :create, :destroy]

  resource :session, only: [:new, :create, :destroy]

  resources :users #, only: [:new, :create]

  resources :account_activations, only: [:edit]


  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy], shallow: true
  end

  get('/', { to: 'posts#index', as: :home})
  get('/users/:id/edit_password', {to: 'users#edit_password', as: :edit_password})
  patch('/users/:id/update_password', {to: 'users#update_password', as: :update_password})
  # get('/posts/new', { to: 'posts#new', as: :new_post})
  # post('/posts', { to: 'posts#create', as: :posts })
  # get('/posts', { to: 'posts#index'})
  # get('/posts/:id', { to: 'posts#show', as: :post})
  # delete('/posts/:id', to: 'posts#destroy')
  # get('/posts/:id/edit', to: 'posts#edit', as: :edit_post)
  # patch('/posts/:id', to: 'posts#update')



  # get('/', to: 'posts#index')
  # get('/posts/new', to: 'posts#new', as: :new_post)
  # post('/posts/', to: 'posts#create', as: :posts)
  # get('/posts/', to: 'posts#index')
  # get('/:token', to: 'posts#show', as: :post)

  resources :password_resets, except: [:index] #only: [:new, :create, :edit, :update]
end
