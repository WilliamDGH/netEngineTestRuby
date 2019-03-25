Rails.application.routes.draw do
  get '/' => 'home#index'
  post '/result' => 'home#result'

end
