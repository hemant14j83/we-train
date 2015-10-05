class Trainer < ActiveRecord::Base
  has_many :qualifications, :dependent => :destroy
  has_many :expertises, :dependent => :destroy

  has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :confirmable, :rememberable, :trackable, :validatable
  devise :omniauthable

  def connect_to_linkedin(auth)
	   self.uid = auth.uid
     self.email = auth.info.email
     self.provider = auth.provider
     self.image_file_name= auth.info.image
     self.update!(
      provider: auth.provider
      )
	 unless self.save
		  return false
 	 end
	 true
  end
  def disconnect_from_linkedin!
	 self.provider = nil
	 self.uid = nil
	 self.trainer_linkedin_connection = nil
	 self.save!
  end
  def self.find_for_linkedin_oauth(auth)
  data = auth.info
  trainer=Trainer.where(:provider=>data.provider,:email=>data.email).first

  if trainer
    return trainer
  else
    registered_trainer=Trainer.where(:email => data.email).first
    if registered_trainer
      return registered_trainer
    else  
      trainer=self.create!(
          password: Devise.friendly_token[0,20],
          email: data.email,
          uid: auth.uid,
          #image_file_name: data.image,
          provider: auth.provider
      )
      trainer.save!
      trainer
    end
  end
  
  end
end