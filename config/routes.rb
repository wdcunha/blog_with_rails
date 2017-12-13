Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get('/', { to: 'posts#index', as: :home})
  # get('/posts', { to: 'posts#index'})

  get('/posts/:id', { to: 'posts#show', as: :post})

end
