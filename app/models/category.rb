class Category < ActiveRecord::Base
has_many :expertlist
validates_uniqueness_of :name, :message=>' already present.'
end
