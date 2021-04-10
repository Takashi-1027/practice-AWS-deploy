Rails.application.routes.draw do
  devise_for :users

  root :to => "homes#top"
  get 'home/about' => 'homes#about'
  # root to: 'homes#top'

  resources :users, only: [:show,:index,:edit,:update] do
   resource :relationships, only: [:create, :destroy]
  get 'follows', 'followers' #followsとfollowersのルーティングを追加した
  end

  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
    # View-bookの中にfavoritesを作るからresouces :booksの中に入れている。
  end

  get 'search' => 'searches#search'

  get '*anything' => 'homes#top'

end
  # get 'book_comments/create'
  # get 'book_comments/destroy'
  # get 'favorites/create'
  # get 'favorites/destroy'