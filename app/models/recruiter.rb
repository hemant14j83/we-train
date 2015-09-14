class Recruiter < ActiveRecord::Base
  has_many :programs, inverse_of: :recruiter, :dependent => :destroy

  accepts_nested_attributes_for :programs
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
end
