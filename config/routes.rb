Rails.application.routes.draw do
  get 'posts/index' => "posts#index"
  get '/' => "home#top"
  get "about" => "home#about"
  get "posts/new" => "posts#new"
  get "posts/:id" => "posts#show"

  post "posts/create" => "posts#create"
end
