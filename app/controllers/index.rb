get '/' do
  erb :index
end

get '/secret' do
  if session[:user_id]
    erb :secret
  else
    redirect '/'  
  end
end

post '/login' do
  if user = User.login(params[:user])
    session[:user_id] = user.id
    erb :secret
  else
    @incorrect_login = true
    erb :index
  end
end

post '/' do
  session[:user_id] = nil
  redirect "/"
end

post '/signup' do
  @user = User.create(params[:user])
  if @user.save
    session[:user_id] = user.id
    redirect '/secret'
  else
    @incorrect_signup = true
    erb :index
  end
end
