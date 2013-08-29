enable :sessions

get '/' do
  if session[:user_id]
    erb :secret
  else
    erb :index
  end
end

post '/login' do
  if user = User.login(params[:email], params[:password])
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
  @user = User.new(params[:user])
  puts params
  @user.password = params[:password]
    # to do more awesomeness to the signup flow
    # if @user.save
    #   do a thing
    #   like redirect
    # else
    #   maybe print out some errors?
    #   and reload the erb
    # end
end
