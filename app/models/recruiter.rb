class Recruiter < ActiveRecord::Base	
  has_many :programs, inverse_of: :recruiter, :dependent => :destroy

  accepts_nested_attributes_for :programs

  validates :firm_name,:email,:firm_type, :presence => true

  has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
end
