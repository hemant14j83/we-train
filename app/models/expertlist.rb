class Expertlist < ActiveRecord::Base
  belongs_to :category
  validates :name, :presence=>true#, :message=>' can\'t be left blank.'
end
