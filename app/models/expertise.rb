class Expertise < ActiveRecord::Base
	belongs_to :trainer
	validate :expertise_count, :on =>:create

	validates :expertise_in, :reference_name, :reference_name1, :reference_email, :reference_number, :presence => true
	validates :reference_email1, :reference_number1, :presence => true
	validates_format_of :reference_email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create, message:'Invalid email format'
	validates_format_of :reference_email1, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create, message:'Invalid email format'
	validates :reference_number, :numericality => {:only_integer=>true, :message => ' is not valid'}
	validates :reference_number1, :numericality => {:only_integer=>true, :message => ' is not valid'}
	validates_length_of :reference_number, is: 10, message: 'Please enter valid mobile number.'

	scope :by_status, -> status{ where(expertise_verified_status: status)}
  	scope :recent, -> {order("programs.created_at DESC")}
  	scope :old, -> {order("created_at ASC")}

	def expertise_count
		trainer=Trainer.find(trainer_id)
		errors.add(:base, "Maximum 5 Expertise Allowed.") if trainer.expertises.count >= 5
	end
end
