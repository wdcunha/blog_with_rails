Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # resource :posts #, only: [:new, :create, :destroy]


  get('/', { to: 'posts#index', as: :home})
  get('/posts/new', { to: 'posts#new', as: :new_post})
  post('/posts', { to: 'posts#create', as: :posts })
  get('/posts', { to: 'posts#index'})
  get('/posts/:id', { to: 'posts#show', as: :post})
  delete('/posts/:id', to: 'posts#destroy')
  get('/posts/:id/edit', to: 'posts#edit', as: :edit_post)
  patch('/posts/:id', to: 'posts#update')


  # get('/', to: 'posts#index')
  # get('/posts/new', to: 'posts#new', as: :new_post)
  # post('/posts/', to: 'posts#create', as: :posts)
  # get('/posts/', to: 'posts#index')
  # get('/posts/:id', to: 'posts#show', as: :post)

end
