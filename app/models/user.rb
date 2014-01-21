class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registerable, 
  
  # devise :database_authenticatable, 
  #        :recoverable, :rememberable, :trackable, :validatable

  # xj: disable the :registerable, not allow user sign up on production.
  if Rails.env.production?
    devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  else
    devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :registerable 
  end

end
