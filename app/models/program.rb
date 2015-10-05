class Program < ActiveRecord::Base
  belongs_to :recruiter, inverse_of: :programs
  has_many :savedprograms, :dependent => :destroy

  validates :name, :program_details, :duration, :payment_detail, :venue, :city, :state, :presence => true
  validates :payment_detail, :numericality =>  {:only_integer=>true, :message => ' is not valid'}
end
