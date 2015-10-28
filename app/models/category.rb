class Category < ActiveRecord::Base
	belongs_to :catable, :polymorphic=>true
	has_many :expertlist
	validates :name, :presence=>true#, :message=>' can\'t be left blank.'
	validates_uniqueness_of :name, :message=>' already present.'
end
