class Savedprogram < ActiveRecord::Base
  #default_scope { where status: 'active' }
  belongs_to :program
  belongs_to :trainer
  scope :by_status, -> status { where(status: status) }
  scope :recent, -> {order("programs.created_at DESC")}

  validates_uniqueness_of :program_id, :scope=> :trainer_id
end
