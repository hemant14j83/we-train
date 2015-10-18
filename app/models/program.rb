class Program < ActiveRecord::Base
  default_scope { where status: 'active' }
  belongs_to :recruiter, inverse_of: :programs
  has_many :savedprograms, :dependent => :destroy

  validates :name, :program_details, :duration, :payment_detail, :city, :presence => true #, :venue, :state
  validates :payment_detail, :numericality =>  {:only_integer=>true, :message => ' is not valid'}
end
