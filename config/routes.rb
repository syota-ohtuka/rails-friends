Rails.application.routes.draw do
	get 'login', to: 'sessions#new'
	post 'login', to: 'sessions#create'
	get 'logout', to: 'sessions#destroy'
	resources :users

	get 'friend/search', to: 'friends#index'
	post 'friend/search', to: 'friends#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
