Rails.application.routes.draw do
	get 'login', to: 'sessions#new'
	post 'login', to: 'sessions#create'
	get 'logout', to: 'sessions#destroy'
	resources :users

	get 'users/:id/follow', to: 'users#follow'
	get 'users/:id/follower', to: 'users#follower'

	get 'friends/search', to: 'friends#index'
	post 'friends/search', to: 'friends#search'
	post 'friends/follow', to: 'friends#create'
	delete 'friends/follow', to: 'friends#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
