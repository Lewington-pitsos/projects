require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

configure do
  enable :sessions
  set :session_secret, "secret"
  use Rack::Session::Cookie, key: 'rack.session',
                             path: '/',
                             secret: 'secret'
end

before '*.js' do
  content_type 'application/javascript'
end

# ----------------------------------------------------------------------- #

not_found do
  content_type 'html'
  redirect '/home'
end

get '/home' do
  erb :home
end

get '/pricing' do
  erb :pricing
end


get '/program' do
  erb :program
end
