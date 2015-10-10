class Career < ActiveRecord::Base
	has_many :functions
	has_many :jobskills
	accepts_nested_attributes_for :functions,
		:allow_destroy => true,
		:reject_if => :all_blank

	validates :position, :department, :presence => true
end
