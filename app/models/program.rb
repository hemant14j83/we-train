class Program < ActiveRecord::Base
  belongs_to :recruiters

  validates :name, :program_details, :duration, :payment_detail, :venue, :city, :state, :presence => true
  validates :payment_detail, :numericality =>  {:only_integer=>true, :message => ' is not valid'}
end
