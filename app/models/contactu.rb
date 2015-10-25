class Contactu < ActiveRecord::Base
	validates :name,:email,:phone,:subject,:presence=>true
	validates :phone,:numericality => {:only_integer=>true, :message => ' is not valid'}
	#validates_length_of :phone, is: 10, message: 'Please enter valid mobile number.'
	validates :phone, length:{in: 10..12}
end
