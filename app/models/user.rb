class User < ActiveRecord::Base
  validates :email, presence: true, uniquness: true
  validates :fullname, presence: true
  validates :password, presence: true

  def create
    @user = User.new(params[:email])
    @user.password = params[:password]
    @user.save!
  end

  def self.authenticate(email, password)
    @user = User.find_by_email(params[:email])
    if @user.password == params[:password]
      true
    else
      @error = true
    end
  end
end
