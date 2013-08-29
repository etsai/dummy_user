enable :sessions

get '/' do
  if session[:user_id]
    erb :secret
  else
    erb :index
  end
end

post '/login' do
  def login
    @user = User.find_by_email(params[:email])
    if @user && @user.password == params[:password_hash]
      session[:user_id] = @user.id
      puts session[:user_id]
      erb :secret
    else
      @incorrect_login = true
      erb :index
    end
  end
  login
end

post '/' do
  session[:user_id] = nil
  redirect "/"
end

post '/signup' do
  def create
    @user = User.new(params)
    @user.password = params[:password_hash]
    @user.save!
  end
  create
end
