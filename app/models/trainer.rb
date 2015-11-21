class Trainer < ActiveRecord::Base
  has_many :qualifications, :dependent => :destroy
  has_many :expertises,->{order "created_at DESC"}, :dependent => :destroy
  has_many :savedprograms,->{order "created_at DESC"},:dependent => :destroy
  has_many :appliedprograms, :dependent => :destroy

  validates_uniqueness_of :email
  validates :email, :full_name,:presence=>true

  has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :confirmable, :rememberable, :trackable, :validatable
  devise :omniauthable

  
  def admin?
    self.role == 'admin'
  end
  def connect_to_linkedin(auth)
	   self.uid = auth.uid
     self.full_name=auth.info.name
     self.email = auth.info.email
     self.provider = auth.provider
     image= auth.info.image
     self.social_image=process_images(image)
     #self.image_file_name="social" 
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
            full_name: auth.info.name,
            #image_file_name: data.image,
            provider: auth.provider
        )
        trainer.save!
        trainer.skip_confirmation!
        trainer
      end
    end
  end
  def process_images(raw_input)
  return [] if raw_input.nil?
  urls = raw_input.split('http')
  urls.shift
  urls.map { |url| "http#{url}".strip.split(/\s\,\;/)[0] }
  end
end