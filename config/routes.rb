Rails.application.routes.draw do
  get '/' => 'home#index'
  get '/result' => 'home#result'

end
