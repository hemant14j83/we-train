class Expertise < ActiveRecord::Base
	belongs_to :trainer

	validates :expertise_in, :reference_name, :reference_email, :reference_number, :presence => true
	validates_format_of :reference_email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create, message:'Invalid email format'
	validates :reference_number, :numericality => {:only_integer=>true, :message => ' is not valid'}
	validates_length_of :reference_number, is: 10, message: 'Please enter valid mobile number.'
end
