class Appliedprogram < ActiveRecord::Base
  belongs_to :trainer
  belongs_to :program
  
  scope :by_status, -> status { where(status: status) }
  scope :recent, -> {order("created_at DESC")}
  
  validates_uniqueness_of :program_id, :scope=> :trainer_id
end
