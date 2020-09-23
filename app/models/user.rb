class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: {minimum: 8}
  before_save :email_downcase

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip.downcase)
    if user && user.authenticate(password.strip)
        return user
    else 
        return nil
    end    
  end
  def email_downcase
      self.email.downcase!
  end
end