class Career < ActiveRecord::Base
	has_many :functions
	accepts_nested_attributes_for :functions,
		:allow_destroy => true,
		:reject_if => :all_blank

	validates :position, :department, :presence => true
end
