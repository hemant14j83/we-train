class Savedprogram < ActiveRecord::Base
  belongs_to :program
  belongs_to :trainer

  validates_uniqueness_of :program_id, :scope=> :trainer_id
end
