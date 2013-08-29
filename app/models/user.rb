
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

  def self.login(email, password)
    if user = User.find_by_email(email)
     return user if user.password == password
    end
  end

end
