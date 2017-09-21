require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

also_reload '/public/scripts/main.js'
configure do
  enable :sessions
  set :session_secret, "secret"
  use Rack::Session::Cookie, key: 'rack.session',
                             path: '/',
                             secret: 'secret'
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


# ----------------------------- EMACScript ---------------- #

get '/main.js' do
  content_type 'application/javascript'
  File.read('public/scripts/main.js');
end
