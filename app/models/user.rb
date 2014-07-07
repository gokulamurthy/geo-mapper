class User < ActiveRecord::Base
  has_secure_password
  
  validates :email, presence: true, uniqueness: true, format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/,
                      message: 'The format of Email is invalid'}
  validates :password, presence: true, length: { minimum: 8 }, confirmation: true,
                          unless: Proc.new { |a| a.password.blank? }
  validates :full_name, presence: true
  
  reverse_geocoded_by :latitude, :longitude, :address => :location 
  
end
