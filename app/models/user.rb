class User < ActiveRecord::Base
  include BCrypt

  validates :email, presence: true, uniqueness: true
  validates :fullname, presence: true
  validates :password_hash, presence: true

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.login(params)
    user = User.find_by_email(params[:email])
    user && user.password == params[:password] ? user : nil
  end

  def self.create(params)
    user = User.new(params)
    user.password = params[:password]
    user.save
    user
  end
end
