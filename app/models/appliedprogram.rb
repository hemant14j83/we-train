class Appliedprogram < ActiveRecord::Base
  belongs_to :trainer
  belongs_to :program

  validates_uniqueness_of :program_id, :scope=> :trainer_id
end
