class Career < ActiveRecord::Base
	validates :position, :presence => true
end
