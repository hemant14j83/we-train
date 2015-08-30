class Qualification < ActiveRecord::Base
  belongs_to :trainer

  validates :course_name, :percentage, :grade, :presence => true
  
end
