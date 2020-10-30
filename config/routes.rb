Rails.application.routes.draw do

  get "users/:id" => "users#show"
  patch "users/:id/update" => "users#update"
  get "users/:id/edit" => "users#edit"
  post "users/create" => "users#create"
  get "signup" => "users#new"
  get 'login' => "users#login_form"
  post 'login' => "users#login"
  post "logout" => "users#logout"
  get '/auth/:provider/callback' => "users#twitter"

  get "tasks/new" => "tasks#new"
  post "tasks/create" => "tasks#create"
  get "tasks/sort_form" => "tasks#sort_form"
  get "tasks/set_sort" => "tasks#set_sort"
  get "tasks/:id" => "tasks#show"
  get "tasks/:id/index" => "tasks#index"
  post "tasks/:id/index" => "tasks#index"
  get "tasks/:id/edit" => "tasks#edit"
  get "tasks/:id/delete" => "tasks#delete"
  get "tasks/:id/complete" => "tasks#complete"
  get "tasks/:id/uncomplete" => "tasks#uncomplete"
  patch "tasks/:id/update" => "tasks#update"


  root "home#top"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
