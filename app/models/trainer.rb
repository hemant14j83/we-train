class Trainer < ActiveRecord::Base
  has_many :qualifications, :dependent => :destroy
  has_many :expertises, :dependent => :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :confirmable, :rememberable, :trackable, :validatable
end
