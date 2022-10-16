Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  # Reference:
  # https://guides.rubyonrails.org/routing.html
  # https://stackoverflow.com/questions/58276226/template-is-missing-missing-template-layouts-site-with-locale-en-format
  get '/find_same_director(/:title)' => 'movies#find_same_director', as: 'same_director_movies'
end
